import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/models/purchases.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:cost_admin/const/phone_auth_user_data.dart';

class PurchaseService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  ///ALL PURCHASES FUTURE
  Future allPurchases() async {
    var res = await firebaseFirestore.collection('purchases').get();
    return purchasesFromJson(res.docs);
  }

  ///ALL PURCHASES STREAM
  getAllPurchases() {
    var res = firebaseFirestore.collection('purchases').snapshots();
    return res;
  }

  ///MY PURCHASES
  getMyPurchasesStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('purchases')
        .where('purchaseByPhone', isEqualTo: phone)
        .snapshots();
    return res;
  }

  ///PURCHASES REQUEST
  getPurchasesRequestStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('purchases')
        .where('costItemPostedByPhone', isEqualTo: phone)
        .snapshots();
    return res;
  }

  ///PURCHASES CHAT DATA
  getPurchasesChatData({required String docId}) {
    var res = firebaseFirestore
        .collection('purchases')
        .doc(docId)
        .collection("chats")
        .orderBy("chatTimestamp")
        .snapshots();
    return res;
  }


  ///COST ITEM PURCHASES
  getMyCoinPurchaseHistory() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('purchases')
        .where('purchaseByPhone', isEqualTo: phone)
        .where('costItemType', isNotEqualTo: 2)
        .snapshots();
    return res;
  }


  ///AUCTION PURCHASES
  getMyAuctionPurchaseHistory() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('purchases')
        .where('purchaseByPhone', isEqualTo: phone)
        .where('costItemType', isEqualTo: 2)
        .snapshots();
    return res;
  }





  ///ADDING CHATS DATA TO THE SUN COLLECTION OF PURCHASES FOR EVERY PURCHASE
  addChatDataToPurchases({
    required String docId,
    required String chatId,
    required String message,
    required String senderName,
    required String senderPhone,
    required String receiverName,
    required String receiverPhone,
  }) {
    firebaseFirestore
        .collection('purchases')
        .doc(docId)
        .collection("chats")
        .add({
      'chatId': chatId,
      'senderName': senderName,
      'senderPhone': senderPhone,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'message': message,
      'chatTimestamp': DateTime.now(),
    });

    return true;
  }



  ///ADD NEW COST ITEM
  Future addPurchaseRequest({
    required String costItemId,
    required int costItemStatus,
    required String costItemHeadline,
    required int costItemType,
    required String costItemPhoto,
    required String costItemDescription,
    required var costItemPrice,
    required String costItemPostedByName,
    required String costItemPostedByPhone,
    required String costItemAddress,
    required GeoPoint costItemCoordinates,

    //PURCHASE DATA
    required String purchaseId,
    required String purchaseByName,
    required String purchaseByPhone,
    required String purchaseByEmail,
    required String purchaseByAddress,
    required GeoPoint purchaseByCoordinates,
  }) async {
    firebaseFirestore.collection('purchases').add({
      'costItemId': costItemId,
      'costItemStatus': costItemStatus,
      'costItemType': costItemType,
      'costItemHeadline': costItemHeadline,
      'costItemPhoto': costItemPhoto,
      'costItemDescription': costItemDescription,
      'costItemPrice': costItemPrice,
      'costItemPostedByName': costItemPostedByName,
      'costItemPostedByPhone': costItemPostedByPhone,
      'costItemCoordinates': costItemCoordinates,
      'costItemAddress': costItemAddress,
      'purchaseId': purchaseId,
      'purchaseByName': purchaseByName,
      'purchaseByPhone': purchaseByPhone,
      'purchaseByEmail': purchaseByEmail,
      'purchaseByAddress': purchaseByAddress,
      'purchaseByCoordinates': purchaseByCoordinates,
      'purchaseTimeStamp': DateTime.now(),
    });

    ///UPDATING COST ITEM STATUS
    firebaseFirestore
        .collection('cost_items')
        .doc("${costItemId}_$costItemPostedByPhone")
        .update({"costItemStatus": 1});

    return true;
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
