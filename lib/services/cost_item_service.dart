import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:cost_admin/models/cost_items.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:cost_admin/const/phone_auth_user_data.dart';

import '../controllers/user_controller.dart';

class CostItemService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  Future allCostItems() async {
    var res = await firebaseFirestore.collection('cost_items').get();
    return costItemsFromJson(res.docs);
  }

  ///ALL COST ITEMS
  getAllCostItemsStream() {
    var res = firebaseFirestore.collection('cost_items').snapshots();
    return res;
  }

  ///MY COST ITEMS
  getMyCostItemsStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('cost_items')
        .where('costItemPostedByPhone', isEqualTo: phone)
        .where('costItemStatus', isEqualTo: 0)
        .snapshots();

    return res;
  }


  ///ALL COIN COST ITEMS
  getAllCoinItemsStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('cost_items')
        .where('costItemType', isEqualTo: 0)
        .where('costItemStatus', isEqualTo: 0)
        .where('costItemPostedByPhone', isNotEqualTo: phone)
        .snapshots();
    return res;
  }

  ///ALL STAMP COST ITEMS
  getAllStampItemsStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('cost_items')
        .where('costItemType', isEqualTo: 1)
        .where('costItemStatus', isEqualTo: 0)
        .where('costItemPostedByPhone', isNotEqualTo: phone)
        .snapshots();
    return res;
  }

  ///ALL AUCTION ITEMS
  getAllAuctionItemsStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('cost_items')
        .where('costItemType', isEqualTo: 2)
        .where('costItemStatus', isEqualTo: 0)
        .where('costItemPostedByPhone', isNotEqualTo: phone)
        .snapshots();
    return res;
  }

  ///ADD NEW COST ITEM
  Future addCostItem(
      {required bool newItem,
      required String costItemId,
      required int costItemStatus,
      required String costItemHeadline,
      required int costItemType,
      //required String costItemPhoto,
      required String costItemDescription,
      required var costItemPrice,
      required String costItemPostedByName,
      required String costItemPostedByPhone,
      required String costItemAddress,
      required GeoPoint costItemCoordinates,
      File? costItemPhotoFile,
      String? costItemIdUpdate}) async {
    String phone = UserData().getUserPhone();

    if (newItem) {
      String imageUrl = '';

      if (costItemPhotoFile != null) {
        var imageTask = await firebaseStorage
            .ref(
                '/cost_item_images/$costItemId/${costItemPhotoFile.path.split('/').last}')
            .putFile(costItemPhotoFile);

        imageUrl = await imageTask.ref.getDownloadURL();
      }

      firebaseFirestore
          .collection('cost_items')
          .doc("${costItemId}_$phone")
          .set({
        'costItemId': costItemId,
        'costItemStatus': costItemStatus,
        'costItemType': costItemType,
        'costItemTimestamp': DateTime.now(),
        'costItemHeadline': costItemHeadline,
        'costItemPhoto': imageUrl,
        'costItemDescription': costItemDescription,
        'costItemPrice': costItemPrice,
        'costItemPostedByName': costItemPostedByName,
        'costItemPostedByPhone': costItemPostedByPhone,
        'costItemCoordinates': costItemCoordinates,
        'costItemAddress': costItemAddress,
      });
    } else {
      firebaseFirestore
          .collection('cost_items')
          .doc("${costItemIdUpdate!}_$phone")
          .update({
        'costItemType': costItemType,
        'costItemHeadline': costItemHeadline,
        'costItemDescription': costItemDescription,
        'costItemPrice': costItemPrice,
      });
    }

    return true;
  }

  ///ADD NEW COST ITEM
  Future postBidAddToDb({
    required CostItems costItems,
    required double bidAmount,
    required String bidId,
  }) async {
    String phone = UserData().getUserPhone();

    firebaseFirestore
        .collection('cost_items')
        .doc("${costItems.costItemId}_${costItems.costItemPostedByPhone}")
        .collection("bids")
        .doc(phone)
        .set({
      'bidId': bidId,
      'bidAmount': bidAmount,
      'bidPostedByPhone': phone,
      'bidTimestamp': DateTime.now(),
      'bidStatus': 0,
      'bidPostedByName': userController.profile!.name,
      'bidPostedByAddress': locationController.address,
      'bidPostedByEmail': userController.profile!.email,
      'bidPostedByCoordinates': GeoPoint(locationController.lat!,locationController.lang!),
    });

    return true;
  }

  //GETS MY BID
  getMyBid({required CostItems costItems}){
    String phone = UserData().getUserPhone();

    var res = firebaseFirestore
        .collection('cost_items')
        .doc("${costItems.costItemId}_${costItems.costItemPostedByPhone}")
        .collection("bids")
        .where('bidPostedByPhone', isEqualTo: phone)
        .snapshots();
    return res;
  }

  //GETS ALL BIDS
  getAllBids({required CostItems costItems}){
    String phone = UserData().getUserPhone();

    var res = firebaseFirestore
        .collection('cost_items')
        .doc("${costItems.costItemId}_${costItems.costItemPostedByPhone}")
        .collection("bids")
        .snapshots();
    return res;
  }


  ///DELETE A COST ITEM
  deleteCostItem(String costItemId) {
    String phone = UserData().getUserPhone();

    var res = firebaseFirestore
        .collection('cost_items')
        .doc("${costItemId}_$phone")
        .delete();
    return true;
  }

  ///OLD DATA BELOW
  //IMPORTANT - USED
  //GETTING ONGOING ORDERS
  getLiveOrdersStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('orders')
        .where('order_by_user', isEqualTo: phone)
        .where('order_status', isNotEqualTo: 6)
        .where('order_status', isGreaterThan: 1)
        .snapshots();
    return res;
  }

  //IMPORTANT - USED
  //GETTING COMPLETED ORDERS
  getPastOrdersStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('orders')
        .where('order_by_user', isEqualTo: phone)
        .where('order_status', isEqualTo: 6)
        .snapshots();
    return res;
  }

  //IMPORTANT - USED
  //GETTING CANCELLED ORDERS
  getCancelledOrdersStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('orders')
        .where('order_by_user', isEqualTo: phone)
        .where('order_status', isEqualTo: -1)
        .snapshots();
    return res;
  }
}
