import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:cost_admin/models/cost_items.dart';
import 'package:cost_admin/models/purchases.dart';
import 'package:cost_admin/services/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/controllers/phone_auth_controller.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/widgets/dialogs.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/toast_message.dart';
import 'package:image_picker/image_picker.dart';

final PurchaseController purchaseController = Get.find<PurchaseController>();

class PurchaseController extends GetxController {

  PurchaseService purchaseService = PurchaseService();

  FocusNode headlineNode = FocusNode(),
      descriptionNode = FocusNode(),
      priceNode = FocusNode(),


      chatNode = FocusNode(),

      confirmPasswordNode = FocusNode(),
      minAmountNode = FocusNode(),
      offerPercentNode = FocusNode(),
      maxDelNode = FocusNode(),
      landmarkNode = FocusNode();

  TextEditingController headlineController = TextEditingController(),
      descriptionController = TextEditingController(),
      priceController = TextEditingController(),

      chatController = TextEditingController(),

      phone = TextEditingController(),
      password = TextEditingController(),
      oilCompany = TextEditingController(),
      confirmPassword = TextEditingController(),
      minAmount = TextEditingController(),
      offerPercentage = TextEditingController(),
      maxDelTime = TextEditingController(),
      description = TextEditingController(),
      address = TextEditingController(),
      landmark = TextEditingController();

  File? image;

  RxInt costItemType = 0.obs;

  GlobalKey<FormState> addCostItemKey = GlobalKey<FormState>();


  List<Purchases> purchases = [];


  var rand = Random();

  ///GETS FUTURE OF PURCHASES - ALL THE DOCUMENTS NOT DYNAMIC AND NOT USED IN THE UI.
  getPurchaseItems() async {
    purchases = await purchaseService.allPurchases();
    update();
  }

  ///SELECT IMAGE
  selectImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      update();
    }
  }


  ///ASSIGNS TO THE EDIT PAGE
  assignCostItemDataForUpdating({required CostItems costItem}){
    headlineController.text = costItem.costItemHeadline;
    descriptionController.text = costItem.costItemDescription;
    priceController.text = costItem.costItemPrice.toString();
    update();
  }


  ///PURCHASE ITEM
  purchaseItem({required CostItems costItem}) async {
    String purchaseId = rand.nextInt(10000).toString() + rand.nextInt(10000).toString();
    try {
      showSpinner();
      var res = await purchaseService.addPurchaseRequest(
          //COST ITEM INFO
          costItemId: costItem.costItemId,
          costItemStatus: 1,
          costItemType: costItem.costItemType,
          costItemHeadline: costItem.costItemHeadline,
          costItemDescription: costItem.costItemDescription,
          costItemPrice: costItem.costItemPrice,
          costItemPostedByName: costItem.costItemPostedByName,
          costItemPostedByPhone: costItem.costItemPostedByPhone,
          costItemPhoto: costItem.costItemPhoto,
          costItemCoordinates: costItem.costItemCoordinates,
          costItemAddress: costItem.costItemAddress,

          //PURCHASER INFO
          purchaseId: purchaseId,
          purchaseByName: userController.profile!.name,
          purchaseByPhone: userController.profile!.phone,
          purchaseByEmail: userController.profile!.email,
          purchaseByAddress: locationController.address,
          purchaseByCoordinates: GeoPoint(locationController.lat!, locationController.lang!)
      );

      if (res) {
        showToast("Purchased", ToastGravity.BOTTOM);

        Future.delayed(1.seconds, () {clearAddCostItemData();},);
      }
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    hideSpinner();
  }



  ///CREATES NEW PURCHASE ITEM FOR AUCTION ITEM IN THE LIST
  acceptBid({required CostItems costItem,required Bids bidsItem}) async {
    String purchaseId = rand.nextInt(10000).toString() + rand.nextInt(10000).toString();


    try {
      showSpinner();
      var res = await purchaseService.addPurchaseRequest(
        //COST ITEM INFO
          costItemId: costItem.costItemId,
          costItemStatus: 1,
          costItemType: costItem.costItemType,
          costItemHeadline: costItem.costItemHeadline,
          costItemDescription: costItem.costItemDescription,
          costItemPrice: costItem.costItemPrice,
          costItemPostedByName: costItem.costItemPostedByName,
          costItemPostedByPhone: costItem.costItemPostedByPhone,
          costItemPhoto: costItem.costItemPhoto,
          costItemCoordinates: costItem.costItemCoordinates,
          costItemAddress: costItem.costItemAddress,

          //PURCHASER INFO
          purchaseId: purchaseId,
          purchaseByName: bidsItem.bidPostedByName!,
          purchaseByPhone: bidsItem.bidPostedByPhone!,
          purchaseByEmail: bidsItem.bidPostedByEmail!,
          purchaseByAddress: bidsItem.bidPostedByAddress!,
          purchaseByCoordinates: bidsItem.bidPostedByCoordinates!,
      );

      if (res) {
        showToast("Purchased", ToastGravity.BOTTOM);

        Future.delayed(1.seconds, () {clearAddCostItemData();},);
      }
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    hideSpinner();
  }

  ///CLEARS ARE ALL THE FIELDS
  clearAddCostItemData(){
    image = null;
    costItemType = 0.obs;
    headlineController.clear();
    descriptionController.clear();
    priceController.clear();

    Get.back();
  }



  ///SEND MESSAGE - FROM CHAT
  sendMessage({required String docId,required Purchases purchaseItem,required bool isBuyer}) async {
    String chatId = rand.nextInt(10000000).toString() + rand.nextInt(1000000).toString();

    try {
      var res;

      isBuyer ?

      res = await purchaseService.addChatDataToPurchases(
          docId: docId,
          chatId: chatId,
          message: chatController.text,
          senderName: purchaseItem.purchaseByName,
          senderPhone: purchaseItem.purchaseByPhone,
          receiverName: purchaseItem.costItemPostedByName,
          receiverPhone: purchaseItem.costItemPostedByPhone
      ) :

      res = await purchaseService.addChatDataToPurchases(
          docId: docId,
          chatId: chatId,
          message: chatController.text,
          senderName: purchaseItem.costItemPostedByName,
          senderPhone: purchaseItem.costItemPostedByPhone,
          receiverName: purchaseItem.purchaseByName,
          receiverPhone: purchaseItem.purchaseByPhone
      );

      if(res){
        chatController.clear();
      }

    } catch (err) {
      Fluttertoast.showToast(msg: "Please Check Connection");
    }
  }



  ///RETURNS COST ITEM TYPE
  getCostItemTypeLabel(itemType){
    if(itemType == 0){
      return "COIN";
    }else{
      return "STAMP";
    }
  }
}





