import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/models/forum.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:cost_admin/const/phone_auth_user_data.dart';


class ForumService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  ///ALL FORUM FUTURE - NOT USED
  Future allForums() async {
    var res = await firebaseFirestore.collection('forum').get();
    return forumFromJson(res.docs);
  }

  ///ALL FORUM STREAM EXCEPT CURRENT USER
  getAllForums() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('forum')
        .where('forumPostedByPhone', isNotEqualTo: phone)
        //.orderBy("forumTimeStamp",descending: true)
        .snapshots();
    return res;
  }

  ///MY FORUMS
  getMyForumStream() {
    String phone = UserData().getUserPhone();
    var res = firebaseFirestore
        .collection('forum')
        .where('forumPostedByPhone', isEqualTo: phone)
        //.orderBy("forumTimeStamp",descending: true)
        .snapshots();
    return res;
  }

  ///GET ALL DISCUSSION DATA
  getForumDiscussionData({required String docId}) {
    var res = firebaseFirestore
        .collection('forum')
        .doc(docId)
        .collection("discussion")
        .orderBy("forumResponseTimestamp",descending: true)
        .snapshots();
    return res;
  }

  ///DELETE FORUM
  deleteForum({required String docId}) {
    var res = firebaseFirestore.collection('forum').doc(docId).delete();
    return true;
  }

  ///ADD NEW FORUM
  Future addOrUpdateForum({
    required bool newItem,
    required String forumId,
    required int forumStatus,
    required String forumHeadline,
    required String forumDescription,
    required String forumPostedByName,
    required String forumPostedByPhone,
    required String forumPostedByPhoto,
    String? docId
  }) async {
    if(newItem){
      firebaseFirestore.collection('forum').add({
        'forumId': forumId,
        'forumStatus': forumStatus,
        'forumHeadline': forumHeadline,
        'forumDescription': forumDescription,
        'forumPostedByName': forumPostedByName,
        'forumPostedByPhone': forumPostedByPhone,
        'forumPostedByPhoto': forumPostedByPhoto,
        'forumTimeStamp': DateTime.now(),
      });
    }else {
      firebaseFirestore.collection('forum').doc(docId).update({
        'forumHeadline': forumHeadline,
        'forumDescription': forumDescription,
      });
    }
    return true;
  }

  ///ADDING DISCUSSION DATA TO THE SUB COLLECTION OF FORUM
  addForumDiscussionData({
    required String docId,
    required String forumResponseId,
    required String senderName,
    required String senderPhone,
    required String senderPhoto,
    required String forumId,
    required String message,
  }) {
    firebaseFirestore
        .collection('forum')
        .doc(docId)
        .collection("discussion")
        .add({
      'forumResponseId': forumResponseId,
      'senderName': senderName,
      'senderPhone': senderPhone,
      'senderPhoto': senderPhoto,
      'forumId': forumId,
      'message': message,
      'forumResponseTimestamp': DateTime.now(),
    });

    return true;
  }
}
