import 'package:cost_admin/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/controllers/phone_auth_controller.dart';
import 'package:cost_admin/views/auth/login_screen.dart';
import 'package:cost_admin/widgets/app_buttons.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/text_field.dart';
import 'package:cost_admin/widgets/will_pop_bottom_sheet.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/screen_size.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///TAKING LOCATION PERMISSION AND ACCESSING LOCATION
    locationController.getLocationPermission();
    locationController.getLatestAddress().whenComplete(() => true);

    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Spinner(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: phoneAuthController.signUpKey,
                    //key: UniqueKey(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        CircleAvatar(
                          backgroundColor: AppColor.white,
                          radius: ScreenSize.width(context) * 0.35,
                          child: Center(
                            child: Image.asset(
                              AppImages.appLogoLight,
                              height: ScreenSize.height(context) * 0.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        //SIGN UP PHONE NUMBER
                        TitleTextField(
                          title: 'Phone',
                          hint: 'Phone',
                          icon: const Icon(Icons.phone,color: AppColor.primaryColor,),
                          controller: phoneAuthController.mobileSignUp,
                          len: 10,
                          keyboardType: TextInputType.phone,
                          validator: (val) =>
                              val!.length == 10 ? null : 'Enter valid Phone Number',
                          onSubmit: (val) =>
                              phoneAuthController.mobileSignUpNode.requestFocus(),
                        ),

                        SizedBox(height: ScreenSize.height(context) * 0.015),

                        //SIGN IN BUTTON - GOES TO HOME OR SHOWS A TOAST
                        CostButton(
                          buttonText: 'SEND OTP',
                          onTap: phoneAuthController.sendOtpToDevice,

                          // onTap: (){
                          //   phoneAuthController.sendOtpAndVerify(context);
                          // },
                        ),

                        SizedBox(height: ScreenSize.height(context) * 0.005),

                        //ALREADY YOU HAVE AN ACCOUNT? - NAVIGATES TO SIGN IN PAGE
                        TextButton(
                          onPressed: () => Get.offAll(
                            () => const LoginScreen(),
                            transition: Transition.rightToLeft,
                            duration: .5.seconds,
                          ),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an account?",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: ScreenSize.height(context) * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
