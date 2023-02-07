import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:cost_admin/models/cost_items.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/controllers/phone_auth_controller.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/services/cost_item_service.dart';
import 'package:cost_admin/widgets/dialogs.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/toast_message.dart';
import 'package:image_picker/image_picker.dart';

final CostItemsController costItemsController = Get.find<CostItemsController>();

class CostItemsController extends GetxController {
  CostItemService costItemsService = CostItemService();

  FocusNode headlineNode = FocusNode(),
      descriptionNode = FocusNode(),
      priceNode = FocusNode(),
      confirmPasswordNode = FocusNode(),
      minAmountNode = FocusNode(),
      offerPercentNode = FocusNode(),
      maxDelNode = FocusNode(),
      landmarkNode = FocusNode(),
      bidAmountNode = FocusNode();

  TextEditingController headlineController = TextEditingController(),
      descriptionController = TextEditingController(),
      priceController = TextEditingController(),
      phone = TextEditingController(),
      password = TextEditingController(),
      oilCompany = TextEditingController(),
      confirmPassword = TextEditingController(),
      minAmount = TextEditingController(),
      offerPercentage = TextEditingController(),
      maxDelTime = TextEditingController(),
      description = TextEditingController(),
      address = TextEditingController(),
      landmark = TextEditingController(),
      bidAmountController = TextEditingController();

  File? image;

  RxInt costItemType = 0.obs;

  GlobalKey<FormState> addCostItemKey = GlobalKey<FormState>();

  List<CostItems> costItems = [];

  var rand = Random();

  ///GETS  OF ORDERS - ALL THE DOCUMENTS NOT DYNAMIC AND NOT USED IN THE UI.
  getCostItems() async {
    costItems = await costItemsService.allCostItems();
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

  assignCostItemDataForUpdating({required CostItems costItem}) {
    headlineController.text = costItem.costItemHeadline;
    descriptionController.text = costItem.costItemDescription;
    priceController.text = costItem.costItemPrice.toString();
    update();
  }

  ///CREATES NEW COST ITEM
  addOrUpdateCostItem({required bool newItem, CostItems? costItem}) async {
    String costItemId =
        rand.nextInt(10000).toString() + rand.nextInt(10000).toString();

    if(newItem){
      if (headlineController.text.isEmpty) {
        showToast("Please enter Headline", ToastGravity.CENTER);
        return;
      }else if (descriptionController.text.isEmpty) {
        showToast("Please enter Description", ToastGravity.CENTER);
        return;
      }else if (priceController.text.isEmpty) {
        showToast("Please enter Price", ToastGravity.CENTER);
        return;
      }else if (image == null) {
        showToast("Please select Image", ToastGravity.CENTER);
        return;
      }
    }

    try {
      showSpinner();
      var res;

      newItem
          ? res = await costItemsService.addCostItem(
              costItemId: costItemId,
              costItemStatus: 0,
              costItemType: costItemType.value,
              costItemHeadline: headlineController.text,
              costItemDescription: descriptionController.text,
              costItemPrice: double.tryParse(priceController.text) ?? 0.00,
              costItemPostedByName: userController.profile!.name,
              costItemPostedByPhone: userController.profile!.phone,
              costItemPhotoFile: image,
              newItem: newItem,
              costItemCoordinates: GeoPoint(locationController.lat!, locationController.lang!),
              costItemAddress: locationController.address)
          : res = await costItemsService.addCostItem(
              costItemId: costItemId,
              costItemStatus: 0,
              costItemType: costItemType.value,
              costItemHeadline: headlineController.text,
              costItemDescription: descriptionController.text,
              costItemPrice: double.tryParse(priceController.text) ?? 0.00,
              costItemPostedByName: userController.profile!.name,
              costItemPostedByPhone: userController.profile!.phone,
              costItemPhotoFile: image,
              newItem: newItem,
              costItemIdUpdate: costItem!.costItemId,
              costItemCoordinates:
                  GeoPoint(locationController.lat!, locationController.lang!),
              costItemAddress: locationController.address);

      if (res) {
        showToast(newItem ? 'Added' : 'Updated', ToastGravity.BOTTOM);

        Future.delayed(
          1.seconds,
          () {
            clearAddCostItemData();
          },
        );
      }
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    hideSpinner();
  }

  ///PLACES A BID
  placeBid({CostItems? costItem}) async {
    String bidId =
        rand.nextInt(10000).toString() + rand.nextInt(10000).toString();

    if (bidAmountController.text.isEmpty) {
      showToast('Please Enter Bid Amount', ToastGravity.BOTTOM);
      return;
    }

    try {
      showSpinner();
      var res = await costItemsService.postBidAddToDb(
        bidId: bidId,
        costItems: costItem!,
        bidAmount:
            double.tryParse(costItemsController.bidAmountController.text) ??
                0.00,
      );

      if (res) {
        showToast('Posted Bid', ToastGravity.BOTTOM);

        Future.delayed(
          1.seconds,
          () {
            clearAddCostItemData();
          },
        );
      }
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    hideSpinner();
  }

  clearAddCostItemData() {
    image = null;
    costItemType = 0.obs;
    headlineController.clear();
    descriptionController.clear();
    priceController.clear();
    update();
    Get.back();
  }

  ///RETURNS COST ITEM TYPE
  getCostItemTypeLabel(itemType) {
    if (itemType == 0) {
      return "COIN";
    } else if (itemType == 1) {
      return "STAMP";
    } else {
      return "AUCTION";
    }
  }

  ///RETURNS ORDER STATUS TEXT AND ICON
  getOrderStatusTextAndIconInfo(orderStatus) {
    switch (orderStatus) {
      case -1:
        return [
          'CANCELLED',
          const Icon(
            Icons.clear_rounded,
            color: AppColor.red,
          )
        ];
      case 0:
        return [
          'PENDING',
          const Icon(
            Icons.timer_rounded,
            color: AppColor.secondaryColor,
          )
        ];
      //break;
      case 1:
        return [
          'ACCEPTED',
          const Icon(Icons.thumb_up_alt_rounded, color: AppColor.secondaryColor)
        ];
      //break;
      case 2:
        return [
          'ASSIGNED',
          const Icon(
            Icons.person_pin_circle_rounded,
            color: AppColor.secondaryColor,
          )
        ];
      //break;
      case 3:
        return [
          'OUT FOR DELIVERY',
          const Icon(
            Icons.fire_truck_rounded,
            color: AppColor.secondaryColor,
          )
        ];
      //break;
      case 4:
        return [
          'DISPENSING',
          const Icon(
            Icons.local_gas_station,
            color: AppColor.secondaryColor,
          )
        ];
      //break;
      case 5:
        return [
          'DISPENSED',
          const Icon(
            Icons.local_gas_station,
            color: AppColor.secondaryColor,
          )
        ];
      //break;
      case 6:
        return [
          'COMPLETED',
          const Icon(
            Icons.check_circle_rounded,
            color: AppColor.green,
          )
        ];
      //break;
      default:
        return [
          'UNKNOWN',
          const Icon(
            Icons.error,
            color: AppColor.red,
          )
        ];
    }
  }
}
