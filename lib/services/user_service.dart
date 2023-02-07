import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cost_admin/const/phone_auth_user_data.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/models/users.dart';

class UserService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  var phone = UserData().getUserPhone();

  ///GETS USER PROFILE
  Future getProfile() async {
    var phone = await UserData().getUserPhone();
    var res = await firebaseFirestore.collection('users').doc(phone).get();
    return userProfileFromJson(res.data());
  }

  ///UPDATES USER PROFILE
  Future<bool> updateProfile(
      {required String name,
      required String phone,
      required String email,
      required String password,
      required bool status,
      required String profileImage,
      File? image}) async {
    String imageUrl = profileImage;

    if (image != null) {
      if (profileImage.isNotEmpty) {
        await firebaseStorage.refFromURL(profileImage).delete();
      }
      var imageTask = await firebaseStorage
          .ref('/user_images/${image.path.split('/').last}')
          .putFile(image);

      imageUrl = await imageTask.ref.getDownloadURL();
    }

    await firebaseFirestore.collection('users').doc(phone).update({
      "name": name,
      "phone": phone,
      "email": email,
      "profile_image": imageUrl,
    });

    return true;
  }

  Future<int> login({
    required String phone,
    required String password,
  }) async {
    var res = await firebaseFirestore
        .collection('users')
        .where("phone", isEqualTo: phone)
        .where("password", isEqualTo: password)
        .get();
    return res.docs.length;
  }

  ///PHONE AUTH - UPDATE PASSWORD
  Future changePassword({required String password}) async {
    var phone = await UserData().getUserPhone();
    await firebaseFirestore
        .collection('users')
        .doc(phone)
        .update({'password': password});
  }


  ///PHONE AUTH FORGOT PASSWORD
  Future changePasswordForgotPassword(
      {required String phoneNum, required String password}) async {
    await firebaseFirestore
        .collection('users')
        .doc(phoneNum)
        .update({'password': password});
  }

  Future deleteUserAccount() async {
    var phone = await UserData().getUserPhone();
    await firebaseFirestore.collection('users').doc(phone).delete();
  }
}


