import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/app_images.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/phone_auth_controller.dart';
import 'package:cost_admin/views/auth/register_screen.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/app_buttons.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
//import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/loading_widget.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Spinner(
        child: Scaffold(
          //key: phoneAuthController.otpPageKey,
          backgroundColor: AppColor.white,
          body: SafeArea(
            child: Form(
              key: phoneAuthController.otpPageKey,
              //key: UniqueKey(),
              //key: pageCode==0 ? phoneAuthController.otpPageKey : phoneAuthController.otpForgotPasswordKey,
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [

                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios,size: 30,),
                            color: AppColor.primaryColor,
                          ),
                        ),

                        SizedBox(
                          height: ScreenSize.width(context) * 0.1,
                        ),

                        //
                        // CircleAvatar(
                        //   backgroundColor: AppColor.white,
                        //   radius: ScreenSize.width(context) * 0.25,
                        //   child: Center(
                        //     child: Image.asset(
                        //       AppImages.appLogo,
                        //       height: ScreenSize.height(context) * 0.25,
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: ScreenSize.width(context) * 0.04,
                        ),

                        Text(
                          'Verification Code',
                          style: TextStyle(
                            fontSize: ScreenSize.width(context) * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize.width(context) * 0.05,
                        ),
                        Text(
                          "Please Enter the OTP",
                          style: TextStyle(
                            fontSize: ScreenSize.width(context) * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              ///PIN CODE TEXT FIELD FOR OTP
                              // Padding(
                              //   padding: const EdgeInsets.all(20.0),
                              //   child: PinCodeTextField(
                              //     appContext: context,
                              //     controller: phoneAuthController.otp,
                              //     length: 6,
                              //     backgroundColor: AppColor.white,
                              //     cursorColor: AppColor.primaryColor,
                              //     obscureText: false,
                              //     // obscuringWidget: ClipRRect(
                              //     //   borderRadius: BorderRadius.circular(30),
                              //     //   child: Image.asset(AppImages.appLogo),
                              //     // ),
                              //     animationType: AnimationType.fade,
                              //     pinTheme: PinTheme(
                              //       shape: PinCodeFieldShape.box,
                              //       activeColor: AppColor.primaryColor,
                              //       disabledColor: AppColor.grey,
                              //       inactiveFillColor: AppColor.white,
                              //       selectedColor: AppColor.primaryColor,
                              //       selectedFillColor: AppColor.white,
                              //       inactiveColor: AppColor.primaryColor,
                              //       borderRadius: BorderRadius.circular(10),
                              //       fieldHeight: ScreenSize.height(context) * 0.08,
                              //       fieldWidth: ScreenSize.width(context) * 0.1,
                              //       activeFillColor: AppColor.white,
                              //     ),
                              //     animationDuration: const Duration(milliseconds: 300),
                              //     onCompleted: (v) {
                              //     },
                              //     onChanged: (value) {
                              //     },
                              //   ),
                              // ),

                              PinCodeTextField(
                                autofocus: false,
                                controller: phoneAuthController.otp,
                                hideCharacter: true,
                                highlight: true,
                                highlightColor: AppColor.primaryColor,
                                defaultBorderColor: AppColor.black,
                                hasTextBorderColor: AppColor.primaryColor,
                                maxLength: 6,
                                hasError: false,
                                maskCharacter: "*",
                                onTextChanged: (text) {
                                  // setState(() {
                                  //   hasError = false;
                                  //   thisText = text;
                                  // });
                                },
                                isCupertino: true,
                                onDone: (text) {
                                  print("DONE $text");
                                },
                                wrapAlignment: WrapAlignment.spaceEvenly,
                                pinBoxDecoration: ProvidedPinBoxDecoration.roundedPinBoxDecoration,
                                pinBoxRadius: 5.0,
                                keyboardType: TextInputType.number,
                                pinBoxOuterPadding: EdgeInsets.all(3),
                                pinBoxBorderWidth: 3,
                                pinBoxHeight: ScreenSize.height(context)*0.1,
                                pinBoxWidth: ScreenSize.width(context)*0.1,
                                pinTextStyle: TextStyle(fontSize: 20.0),
                                pinTextAnimatedSwitcherTransition:
                                    ProvidedPinBoxTextAnimation.scalingTransition,
                                pinTextAnimatedSwitcherDuration:
                                    Duration(milliseconds: 300),
                                highlightAnimation: true,
                                highlightAnimationBeginColor: Colors.black,
                                highlightAnimationEndColor: Colors.white12,
                              ),


                              SizedBox(
                                height: ScreenSize.width(context) * 0.04,
                              ),

                              //SIGN IN BUTTON - GOES TO HOME OR SHOWS A TOAST
                              CostButton(
                                buttonText: 'CONTINUE',
                                onTap: () => phoneAuthController
                                    .verifyOtpAtOtpPage(context),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: ScreenSize.width(context) * 0.04,
                        ),

                        Text(
                          "Didn't receive any code?",
                          style: TextStyle(
                            fontSize: ScreenSize.width(context) * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(
                          height: ScreenSize.width(context) * 0.025,
                        ),

                        TextButton(
                          onPressed: () async {
                            await phoneAuthController.sendOtp();
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Resend Code",
                                  style: TextStyle(
                                    fontSize: ScreenSize.width(context) * 0.04,
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
