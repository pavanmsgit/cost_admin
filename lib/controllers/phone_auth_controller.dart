// ignore_for_file:prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors,file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/phone_auth_user_data.dart';
import 'package:cost_admin/services/auth_service.dart';
import 'package:cost_admin/views/auth/change_password_screen.dart';
import 'package:cost_admin/views/auth/otp_forgot_password.dart';
import 'package:cost_admin/views/auth/otp_screen.dart';
import 'package:cost_admin/views/auth/register_screen.dart';
import 'package:cost_admin/views/home_main/home_screen_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../views/auth/login_screen.dart';
import '../widgets/loading_widget.dart';
import '../widgets/toast_message.dart';

final PhoneAuthController phoneAuthController = Get.find<PhoneAuthController>();

class PhoneAuthController extends GetxController {
  RxBool phoneAvailable = true.obs,
      loginObscure = false.obs,
      registerPasswordObscure = false.obs,
      registerConfirmObscure = false.obs;

  RxInt genderSwitchValue = 0.obs;

  String verificationId = '';

  String gender = "Others";

  FocusNode mobileNode = FocusNode(),
      mobileForgotPasswordNode = FocusNode(),
      mobileSignUpNode = FocusNode(),
      otpNode = FocusNode(),
      nameNode = FocusNode(),
      emailNode = FocusNode(),
      passwordNode = FocusNode(),
      confirmPasswordNode = FocusNode();

  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      mobile = TextEditingController(),
      mobileForgotPassword = TextEditingController(),
      mobileSignUp = TextEditingController(),
      password = TextEditingController(),
      confirmPassword = TextEditingController(),
      otp = TextEditingController();

  final GlobalKey<FormState> registerKey = GlobalKey<FormState>(),
      loginKey = GlobalKey<FormState>(),
      forgotPassword = GlobalKey<FormState>(),
      signUpKey = GlobalKey<FormState>(),
      otpPageKey = GlobalKey<FormState>(),
      otpForgotPasswordKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  PhoneAuthService authService = PhoneAuthService();
  UserData userData = UserData();

  isPhoneAvailable({String? val}) async {
    try {
      var res = await authService.checkPhone(phone: val!);
      phoneAvailable.value = res == 0;
    } catch (_) {
      phoneAvailable.value = false;
    }
  }

  //CHECKING IF USER IS LOGGED IN OR NOT
  checkAuth() {
    Future.delayed(2.seconds, () async {
      String user = await userData.getUserPhone();
      if (user.isEmpty) {
        Get.off(() => const LoginScreen());
      } else {
        //TODO
        //userController.retailerProfile();
        Get.off(() => const HomeScreenMain());
      }
    });
  }

  sendOtpToDevice() async {
    if (signUpKey.currentState!.validate()) {
      if (mobileSignUp.text.isEmpty) {
        Get.snackbar(
          'Enter Valid Number',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        mobileSignUpNode.unfocus();
        mobileForgotPasswordNode.unfocus();
        sendOtp();
      }
    }
  }

  sendOtp() async {
    showSpinner(message: 'Sending Otp...');
    //String countryCode = phone.text.length == 10 ? '+91' : '+974';
    String countryCode = '+91';
    print("phone.text  ${mobileSignUp.text}");
    auth.verifyPhoneNumber(
        phoneNumber: "$countryCode${mobileSignUp.text}",
        //phoneNumber: "+918296731873",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) async {
          otpNode.unfocus();
          showSpinner(message: 'Verifying...');
          auth.signInWithCredential(authCredential).then((result) async {
            var res = await authService.checkUserLoggedInDatabase(
                phone: mobileSignUp.text);
            hideSpinner();
            if (res == 0) {
              await userData.setUserPhone(phone: mobileSignUp.text);
              Get.to(() => const RegisterScreen());
            } else {
              Get.snackbar(
                'Already Exists',
                '',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
              );
            }
          }).catchError((_) {
            hideSpinner();
          });
        },
        verificationFailed: (authException) {
          // print(authException);
          hideSpinner();
          Get.snackbar(
            authException.toString(),
            '',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
          );
        },
        codeSent: (verId, i) async {
          verificationId = verId;
          hideSpinner();
          showSpinner(message: 'Otp Sent');
          otp = TextEditingController(text: '');
          Future.delayed(Duration(seconds: 1), () {
            hideSpinner();
            Get.to(() => OtpScreen());
          });
          update();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          // print(verificationId);
        });
  }

  //FORGOT PASSWORD PAGE - MAIN METHOD
  sendOtpToDeviceForgotPassword() async {
    if (forgotPassword.currentState!.validate()) {
      if (mobileForgotPassword.text.isEmpty) {
        Get.snackbar('Enter Valid Number', '',
            snackPosition: SnackPosition.BOTTOM,
            borderColor: AppColor.primaryColor);
      } else {
        var res = await authService.checkUserLoggedInDatabase(
            phone: mobileForgotPassword.text);
        if (res == 1) {
          mobileForgotPasswordNode.unfocus();
          sendOtpForgotPassword();
        } else {
          showToast('USER NOT FOUND', ToastGravity.BOTTOM);
          Get.back();
        }
      }
    }
  }

  //FORGOT PASSWORD PAGE
  sendOtpForgotPassword() async {
    showSpinner(message: 'Sending Otp...');
    //String countryCode = phone.text.length == 10 ? '+91' : '+974';
    String countryCode = '+91';
    print("phone.text  ${mobileForgotPassword.text}");
    auth.verifyPhoneNumber(
        phoneNumber: "$countryCode${mobileForgotPassword.text}",
        //phoneNumber: "+918296731873",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) async {
          otpNode.unfocus();
          showSpinner(message: 'Verifying...');
          auth.signInWithCredential(authCredential).then((result) async {
            var res = await authService.checkUserLoggedInDatabase(
                phone: mobileForgotPassword.text);
            hideSpinner();
            if (res == 0) {
              Get.snackbar(
                'User Not Found',
                '',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
              );
            } else {
              //await userData.setUserPhone(phone: mobileForgotPassword.text);
              Get.to(() => const ChangePasswordForgotPassword());
            }
          }).catchError((_) {
            hideSpinner();
          });
        },
        verificationFailed: (authException) {
          // print(authException);
          hideSpinner();
          Get.snackbar(
            authException.toString(),
            '',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
          );
        },
        codeSent: (verId, i) async {
          verificationId = verId;
          hideSpinner();
          showSpinner(message: 'Otp Sent');
          otp = TextEditingController(text: '');
          Future.delayed(Duration(seconds: 1), () {
            hideSpinner();
            Get.to(() => OtpScreenForgotPassword());
          });
          update();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          // print(verificationId);
        });
  }

  //REGISTRATION SCREEN
  verifyOtpAtOtpPage(context) async {
    if (otpPageKey.currentState!.validate()) {
      if (otp.text.length != 6) {
        showToast('Enter Valid 6 digit OTP',ToastGravity.BOTTOM);
      } else {
        try {
          otpNode.unfocus();
          var credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: otp.text,
          );
          showSpinner(message: 'Verifying the number');
          auth.signInWithCredential(credential).then((result) async {
            ///VERIFYING OTP AND NAVIGATING TO NEXT PAGE

                 verifyOtp(context);

          }).catchError((e) {
            hideSpinner();
            Get.snackbar(
              e.toString(),
              '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            );
          });
        } catch (e) {
          // print(e);
          hideSpinner();
        }
      }
    }
  }

  //FORGOT PASSWORD SCREEN
  verifyOtpAtOtpPageForgotPassword(context) async {
    if (otpForgotPasswordKey.currentState!.validate()) {
      if (otp.text.length != 6) {
        showToast('Enter Valid 6 digit OTP',ToastGravity.BOTTOM);
      } else {
        try {
          otpNode.unfocus();
          var credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: otp.text,
          );
          showSpinner(message: 'Verifying the number');
          auth.signInWithCredential(credential).then((result) async {
            ///VERIFYING OTP AND NAVIGATING TO NEXT PAGE
            verifyOtpForgotPassword(context);
          }).catchError((e) {
            hideSpinner();
            Get.snackbar(
              e.toString(),
              '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            );
          });
        } catch (e) {
          // print(e);
          hideSpinner();
        }
      }
    }
  }


  Future verifyOtp(context) async {
    try {
      showSpinner();
      //var user = await authService.loginUser(mobile: mobile.text);
      var user =
          await authService.checkUserLoggedInDatabase(phone: mobileSignUp.text);
      hideSpinner();
      if (user == 1) {
        showToast('Account Already Exists', ToastGravity.BOTTOM);
      } else if (user == 0) {
        showToast('Verified', ToastGravity.BOTTOM);
        otp = TextEditingController(text: '');
        update();
        await userData.setUserPhone(phone: mobile.text);
        Get.to(() => const RegisterScreen());
      } else {
        showToast('Please retry after sometime', ToastGravity.BOTTOM);
      }
    } catch (e) {
      hideSpinner();
    }
  }

  Future verifyOtpForgotPassword(context) async {
    try {
      showSpinner();
      var user = await authService.checkUserLoggedInDatabase(phone: mobileForgotPassword.text);
      hideSpinner();
      if (user == 1) {
        showToast('Verified', ToastGravity.BOTTOM);
        otp = TextEditingController(text: '');
        update();
        Get.to(() => const ChangePasswordForgotPassword());
      } else if (user == 0) {
        showToast('Account Not Found', ToastGravity.BOTTOM);
      } else {
        Get.snackbar(
          'Please retry after sometime',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      hideSpinner();
    }
  }

  ///LOGIN USER - IF ALREADY REGISTERED
  ///TODO - CHECK PASSWORD WRONG AND SHOW TOAST
  loginUser() async {
    if (loginKey.currentState!.validate()) {
      showSpinner();
      try {
        int res = await authService.checkIfUserIsRegistered(
            phone: mobile.text, password: password.text);
        if (res == 1) {
          await userData.setUserPhone(phone: mobile.text);
          Get.offAll(
            () => const HomeScreenMain(),
          );
        } else {
          showToast('Invalid User Check Phone and Password', ToastGravity.BOTTOM);
        }
      } catch (err) {
        showToast('Server Not Found', ToastGravity.BOTTOM);
      }
      hideSpinner();
    }
  }

  // checkIfUserExists() async {
  //     showSpinner();
  //     try {
  //       int res = await authService.checkIfUserIsRegisteredPhone(
  //           phone: mobileForgotPassword.text);
  //       if (res == 1) {
  //         //await userData.setUserPhone(phone: mobile.text);
  //         sendOtpForgotPassword();
  //         Get.to(
  //               () => OtpScreen(pageCode: 1,),
  //           transition: Transition.rightToLeft,
  //           duration: 0.5.seconds,
  //         );
  //       } else {
  //         showToast('User Not Found',ToastGravity.BOTTOM);
  //         Get.back();
  //       }
  //     } catch (err) {
  //       showToast('Please restart the application.',ToastGravity.BOTTOM);
  //     }
  //     hideSpinner();
  // }

  submitRegister() async {
    if (!phoneAvailable.value) {
      showToast('Phone is already registered',ToastGravity.BOTTOM);
    } else if (name.text == '') {
      showToast('Please enter Name',ToastGravity.BOTTOM);
    } else if (email.text == '') {
      showToast('Please enter Email',ToastGravity.BOTTOM);
    } else if (password.text != confirmPassword.text) {
      showToast('Both passwords should match',ToastGravity.BOTTOM);
      return;
    } else if (registerKey.currentState!.validate()) {
      showSpinner();
      try {
        bool res = await authService.registerUser(
          name: name.text,
          email: email.text,
          phone: mobileSignUp.text,
          password: password.text,
        );

        if(res){
          await userData.setUserPhone(phone: mobileSignUp.text);
          Get.offAll(() => const HomeScreenMain());
        }

      } catch (err) {
        Fluttertoast.showToast(msg: err.toString());
      }
      hideSpinner();
    }
  }

  bool hasCallSupport = false;
  Future<void>? launched;

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
