import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:cost_admin/controllers/phone_auth_controller.dart';
import 'package:cost_admin/views/auth/forgot_password_screen.dart';
import 'package:cost_admin/views/auth/login_screen.dart';
import 'package:cost_admin/views/auth/register_screen.dart';
import 'package:cost_admin/views/auth/sign_up_screen.dart';
import 'package:cost_admin/widgets/app_buttons.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/text_field.dart';
import 'package:cost_admin/widgets/will_pop_bottom_sheet.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/screen_size.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
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
                    key: phoneAuthController.forgotPassword,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        CircleAvatar(
                          backgroundColor: AppColor.white,
                          radius: ScreenSize.width(context) * 0.25,
                          child: Center(
                            child: Image.asset(
                              AppImages.appLogoDark,
                              height: ScreenSize.height(context) * 0.25,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        //PHONE NUMBER
                        TitleTextField(
                          title: 'Phone',
                          hint: 'Phone',
                          cursorColor:AppColor.primaryColor,
                          icon: const Icon(Icons.phone,color: AppColor.primaryColor,),
                          controller: phoneAuthController.mobileForgotPassword,
                          keyboardType: TextInputType.phone,
                          validator: (val) =>
                          val!.length == 10 ? null : 'Enter valid Phone Number',
                          onSubmit: (val) =>
                              phoneAuthController.mobileForgotPasswordNode.requestFocus(),
                        ),

                        // //PASSWORD
                        // Obx(
                        //       () => TitleTextField(
                        //     title: 'Password',
                        //     hint: 'Password',
                        //     cursorColor:AppColor.primaryColor,
                        //     icon: const Icon(Icons.key,color: AppColor.primaryColor,),
                        //     controller: phoneAuthController.password,
                        //     obscure: phoneAuthController.loginObscure.value,
                        //     iconData: phoneAuthController.loginObscure.value
                        //         ? Icons.visibility
                        //         : Icons.visibility_off,
                        //     iconTap: () => phoneAuthController.loginObscure.value =
                        //     !phoneAuthController.loginObscure.value,
                        //     node: phoneAuthController.passwordNode,
                        //     validator: (val) => val!.length >= 6
                        //         ? null
                        //         : 'Should have minimum 6 characters',
                        //   ),
                        // ),



                        //SIGN IN BUTTON - GOES TO HOME OR SHOWS A TOAST
                        CostButton(
                          buttonText: 'SEND OTP',
                          //onTap: phoneAuthController.checkIfUserExists,
                          onTap: phoneAuthController.sendOtpToDeviceForgotPassword,
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //DON'T HAVE AN ACCOUNT? - NAVIGATES TO SIGN UP PAGE
                        //FORGOT PASSWORD? - NAVIGATES TO RESET PASSWORD PAGE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                      text: "Remember password? Login",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
