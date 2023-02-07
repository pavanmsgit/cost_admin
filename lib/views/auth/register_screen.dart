import 'package:auto_size_text/auto_size_text.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/will_pop_bottom_sheet.dart';
import 'package:toggle_switch/toggle_switch.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:place_picker/place_picker.dart';
import '../../const/app_colors.dart';
import '../../const/screen_size.dart';
import '../../controllers/phone_auth_controller.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    ///TAKING LOCATION PERMISSION AND ACCESSING LOCATION
    locationController.getLocationPermission();
    locationController.getLatestAddress().whenComplete(() => true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Spinner(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.white,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: GetBuilder(
                init: PhoneAuthController(),
                builder: (_) => Form(
                  key: phoneAuthController.registerKey,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
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


                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [



                                  const SizedBox(height: 10),

                                  SizedBox(
                                    height: ScreenSize.width(context) * 0.025,
                                  ),

                                  ///HEADER
                                  const AutoSizeText(
                                    'REGISTER DETAILS',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.blackMild),
                                  ),



                                  SizedBox(
                                    height: ScreenSize.width(context) * 0.04,
                                  ),

                                  ///NAME
                                  TitleTextField(
                                    title: 'Name',
                                    hint: 'Name',
                                    icon: const Icon(
                                      Icons.person,
                                      color: AppColor.primaryColor,
                                    ),
                                    controller: phoneAuthController.name,
                                    onSubmit: (val) =>
                                        phoneAuthController.nameNode.requestFocus(),
                                    validator: (val) =>
                                        val!.isEmpty ? 'Enter your name' : null,
                                  ),

                                  ///EMAIL
                                  TitleTextField(
                                    title: 'Email',
                                    hint: 'Email',
                                    icon: const Icon(
                                      Icons.email,
                                      color: AppColor.primaryColor,
                                    ),
                                    controller: phoneAuthController.email,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) => val!.isEmail
                                        ? null
                                        : 'Enter valid email address',
                                    onSubmit: (val) => phoneAuthController.emailNode
                                        .requestFocus(),
                                  ),



                                  ///PHONE NUMBER - ALREADY ENTERED
                                  TitleTextField(
                                    title: 'Phone',
                                    hint: 'Phone',
                                    enabled: false,
                                    icon: const Icon(
                                      Icons.phone,
                                      color: AppColor.primaryColor,
                                    ),
                                    len: 10,
                                    controller: phoneAuthController.mobileSignUp,
                                    keyboardType: TextInputType.phone,
                                    validator: (val) => val!.length == 10
                                        ? null
                                        : 'Enter valid Phone Number',
                                    onSubmit: (val) => phoneAuthController
                                        .mobileSignUpNode
                                        .requestFocus(),
                                  ),

                                  ///PASSWORD
                                  Obx(
                                    () => TitleTextField(
                                      title: 'Password',
                                      hint: 'Password',
                                      controller: phoneAuthController.password,
                                      icon: const Icon(
                                        Icons.key,
                                        color: AppColor.primaryColor,
                                      ),
                                      obscure: phoneAuthController
                                          .registerPasswordObscure.value,
                                      iconData: phoneAuthController
                                              .registerPasswordObscure.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      iconTap: () => phoneAuthController
                                              .registerPasswordObscure.value =
                                          !phoneAuthController
                                              .registerPasswordObscure.value,
                                      validator: (val) => val!.length >= 6
                                          ? null
                                          : 'Should have minimum 6 characters',
                                    ),
                                  ),



                                  ///CONFIRM PASSWORD
                                  Obx(
                                    () => TitleTextField(
                                      title: 'Confirm Password',
                                      hint: 'Confirm Password',
                                      icon: const Icon(
                                        Icons.key,
                                        color: AppColor.primaryColor,
                                      ),
                                      controller:
                                          phoneAuthController.confirmPassword,
                                      obscure: phoneAuthController
                                          .registerConfirmObscure.value,
                                      iconData: phoneAuthController
                                              .registerConfirmObscure.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      iconTap: () => phoneAuthController
                                              .registerConfirmObscure.value =
                                          !phoneAuthController
                                              .registerConfirmObscure.value,
                                      validator: (val) => val!.length >= 6
                                          ? null
                                          : 'Should have minimum 6 characters',
                                    ),
                                  ),



                                  const SizedBox(height: 10),



                                  ///REGISTER BUTTON
                                  CostButton(
                                    buttonText: 'REGISTER',
                                    onTap: phoneAuthController.submitRegister,
                                  ),
                                ],
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
        ),
      ),
    );
  }
}

///OLD EMAIL WITH VALIDATION
// TitleTextField(
//   title: 'Email Address',
//   controller: authController.email,
//   keyboardType: TextInputType.emailAddress,
//   validator: (val) => val!.isEmail
//       ? null
//       : 'Enter valid email address',
//   onChanged: (val) =>
//       authController.isEmailAvailable(val: val),
// ),
// if (authController.email.text.isEmail)
//   Obx(
//     () => Text(
//       authController.emailAvailable.value
//           ? 'Email Available'
//           : 'Email already exists',
//       textAlign: TextAlign.end,
//       style: TextStyle(
//         color: authController.emailAvailable.value
//             ? Colors.green
//             : Colors.red,
//       ),
//     ),
//   ),
