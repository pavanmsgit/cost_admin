import 'dart:math';
import 'package:cost_admin/models/forum.dart';
import 'package:cost_admin/services/forum_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/toast_message.dart';

final ForumController forumController = Get.find<ForumController>();

class ForumController extends GetxController {

  ForumService forumService = ForumService();

  FocusNode headlineNode = FocusNode(),
      descriptionNode = FocusNode(),
      chatNode = FocusNode();

  TextEditingController headlineController = TextEditingController(),
      descriptionController = TextEditingController(),
      chatController = TextEditingController();



  GlobalKey<FormState> addForumData = GlobalKey<FormState>();

  var rand = Random();

  assignForumDataForUpdating({required Forum forumItem}){
    headlineController.text = forumItem.forumHeadline;
    descriptionController.text = forumItem.forumDescription;
    update();
  }


  ///CREATES NEW COST ITEM
  addOrEditForum({required bool newItem,Forum? forumItem,String? docId}) async {
    String forumId = rand.nextInt(1000000).toString() + rand.nextInt(10000).toString();


    if(newItem){
      if (headlineController.text.isEmpty) {
        showToast("Please enter Headline", ToastGravity.CENTER);
        return;
      }else if (descriptionController.text.isEmpty) {
        showToast("Please enter Description", ToastGravity.CENTER);
        return;
      }
    }

    try {
      showSpinner();

      var res;

      newItem ?

      res = await forumService.addOrUpdateForum(
          forumId: forumId,
          forumStatus: 0,
          forumHeadline: headlineController.text,
          forumDescription: descriptionController.text,
          forumPostedByName: userController.profile!.name,
          forumPostedByPhone:  userController.profile!.phone,
          forumPostedByPhoto:  userController.profile!.profileImage,
          newItem: newItem,)

          :

      res = await forumService.addOrUpdateForum(
          forumId: forumId,
          forumStatus: 0,
          forumHeadline: headlineController.text,
          forumDescription: descriptionController.text,
          forumPostedByName: userController.profile!.name,
          forumPostedByPhone:  userController.profile!.phone,
          forumPostedByPhoto:  userController.profile!.profileImage,
          newItem: newItem,
          docId: docId
      );


      if (res) {
        showToast(newItem ? 'Posted' : 'Updated', ToastGravity.BOTTOM);

        Future.delayed(1.seconds, () {clearAddForumData();},);
      }
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    hideSpinner();
  }





  ///CLEARS FORUM DATA
  clearAddForumData(){
    headlineController.clear();
    descriptionController.clear();
    Get.back();
  }



  ///ADDS DISCUSSION DATA TO FORUM
  addDiscussionToForum({required String docId,required Forum forumItem}) async {
    String forumResponseId = rand.nextInt(10000000).toString() + rand.nextInt(1000000).toString();

    try {
      var  res = await forumService.addForumDiscussionData(docId: docId,
          forumResponseId: forumResponseId,
          senderName: userController.profile!.name,
          senderPhone: userController.profile!.phone,
          senderPhoto: userController.profile!.profileImage,
          forumId: forumItem.forumId,
          message: chatController.text);

      if(res){
        chatController.clear();
      }
    } catch (err) {
      Fluttertoast.showToast(msg: "Please Check Connection");
    }
  }
}





