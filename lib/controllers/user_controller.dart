import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cost_admin/const/app_images.dart';
import 'package:cost_admin/controllers/phone_auth_controller.dart';
import 'package:cost_admin/models/users.dart';
import 'package:cost_admin/services/auth_service.dart';
import 'package:cost_admin/services/user_service.dart';
import 'package:cost_admin/views/auth/login_screen.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/toast_message.dart';


final UserController userController = Get.find<UserController>();

class UserController extends GetxController {
  RxBool isSelected = false.obs,
      passwordObscure = true.obs,
      confirmPasswordObscure = true.obs,
      currentPasswordObscure = true.obs,
      //CHANGE PASSWORD PAGE UNDER PROFILE PAGE
      currentPasswordValidated = false.obs,
      passwordOneUpdated = false.obs,
      passwordTwoUpdated = false.obs;

  double lat = 0.00, lon = 0.00;

  File? image;

  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>(),
      changePasswordFormKey = GlobalKey<FormState>(),
      changePasswordForgotPasswordFormKey = GlobalKey<FormState>(),
      updateProfileKey = GlobalKey<FormState>();


  bool? status;

  User? profile;

  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      phone = TextEditingController(),
      password = TextEditingController(),
      confirmPassword = TextEditingController(),
      currentPassword = TextEditingController(),
      newPassword = TextEditingController(),
      confirmNewPassword = TextEditingController();



  String imageUrl = '';
  UserService userService = UserService();
  PhoneAuthService authService = PhoneAuthService();


  ///UPDATES USER PROFILE DATA
  getUserProfile() async {
    profile = await userService.getProfile();
    name.text = profile!.name;
    email.text = profile!.email;
    phone.text = profile!.phone;
    password.text = profile!.password;
    confirmPassword.text = profile!.password;
    status = profile!.status;
    imageUrl = profile?.profileImage ?? "";
    update();
  }

  ///CHANGE PASSWORD FROM PROFILE
  changePassword() async {
    if (changePasswordFormKey.currentState!.validate()) {
      if (currentPassword.text != userController.profile!.password) {
        debugPrint("checking ${currentPassword.text} ${profile!.password}");
        showToast('Current password is not correct', ToastGravity.CENTER);
        return;
      } else if (newPassword.text != confirmNewPassword.text) {
        showToast('Both passwords should be same', ToastGravity.CENTER);
        return;
      } else if (currentPassword.text == newPassword.text) {
        showToast('Old and new passwords cannot be same', ToastGravity.CENTER);
        return;
      } else if (currentPassword.text.isEmpty ||
          newPassword.text.isEmpty ||
          confirmNewPassword.text.isEmpty) {
        showToast('Please Enter All The Fields', ToastGravity.CENTER);
      }
      showSpinner();
      try {
        await userService.changePassword(password: newPassword.text);
        currentPassword.clear();
        newPassword.clear();
        confirmNewPassword.clear();
        currentPasswordValidated = false.obs;
        passwordOneUpdated = false.obs;
        passwordTwoUpdated = false.obs;

        userController.getUserProfile();
        update();
        showToast('Password changed', ToastGravity.CENTER);
        Get.back();
      } catch (err) {
        Fluttertoast.showToast(msg: err.toString());
      }
      hideSpinner();
    }
  }

  //SUB - METHOD FOR CHANGE PASSWORD
  updateTheUpdateButtonColor() async {
    if (changePasswordFormKey.currentState!.validate()) {
      if (currentPassword.text == userController.profile!.password) {
        currentPasswordValidated = true.obs;
        update();
        showToast('Current password matched', ToastGravity.BOTTOM);
        return;
      }
      if (newPassword.text.isNotEmpty) {
        passwordOneUpdated = true.obs;
        update();
      }
      if (confirmNewPassword.text.isNotEmpty) {
        passwordTwoUpdated = true.obs;
        update();
      }
    }
  }

  ///CHANGE PASSWORD FROM FORGOT PASSWORD
  changePasswordForgotPassword() async {
    if (changePasswordForgotPasswordFormKey.currentState!.validate()) {
      if (newPassword.text != confirmNewPassword.text) {
        showToast('Both passwords should be same', ToastGravity.CENTER);
        return;
      } else if (newPassword.text.isEmpty || confirmNewPassword.text.isEmpty) {
        showToast('Please Enter All The Fields', ToastGravity.CENTER);
      }
      showSpinner();
      try {
        print(
            "TESTING IN CHANGE PASSWORD FORGOT PASSWORD METHOD ${phoneAuthController.mobileForgotPassword.text}  ${newPassword.text}");
        await userService.changePasswordForgotPassword(
            phoneNum: phoneAuthController.mobileForgotPassword.text,
            password: newPassword.text);
        newPassword.clear();
        confirmNewPassword.clear();
        update();
        showToast('Password Updated Successfully', ToastGravity.BOTTOM);
        Get.offAll(
          () => const LoginScreen(),
          transition: Transition.rightToLeft,
          duration: 1.seconds,
        );
      } catch (err) {
        showToast(err.toString(), ToastGravity.BOTTOM);
      }
      hideSpinner();
    }
  }

  ///SELECTS IMAGE FROM THE DEVICE
  selectImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      update();
    }
  }

  ///UPDATES USER PROFILE - CALLS DB FUNCTION
  updateProfile() async {
    if (updateProfileKey.currentState!.validate()) {
      showSpinner();
      try {
        bool res = await userService.updateProfile(
            name: name.text,
            email: email.text,
            phone: phone.text,
            password: password.text,
            image: image,
            profileImage: imageUrl,
            status: true,);
        if (res) {
          image = null;
          getUserProfile();
          Fluttertoast.showToast(msg: 'Profile Updated');
        }
      } catch (err) {
        print(err);
        Fluttertoast.showToast(msg: err.toString());
      }
      hideSpinner();
    }
  }


  ///LOGOUT USER FROM THE DEVICE
  logoutUser() async {
    showToast('LOGGED OUT', ToastGravity.CENTER);
    GetStorage().erase();
    Get.offAll(() => const LoginScreen());
  }

  ///DELETE USER - NOT USED - DON NOT USE
  deleteUserAccount() async {
    showToast('DELETING ACCOUNT', ToastGravity.CENTER);
    userService.deleteUserAccount();
    Get.offAll(() => LoginScreen());
    //update();
  }
}
