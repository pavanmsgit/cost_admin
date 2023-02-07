import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/app_buttons.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/text_field.dart';
import '../../../widgets/text_field.dart';

class ChangePasswordForgotPassword extends StatelessWidget {
  const ChangePasswordForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserController(),
      builder: (_) => Spinner(
        child: Form(
          key: userController.changePasswordForgotPasswordFormKey,
          child: Scaffold(
            backgroundColor: AppColor.white,
            body: SafeArea(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(child:

                    Column(
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
                          padding: EdgeInsets.all(20),
                          child: ListBody(
                            children: [
                              Obx(
                                    () => TitleTextField(
                                  title: 'New Password',
                                  hint: 'New Password',
                                  cursorColor: AppColor.black,
                                  textColor: AppColor.black,
                                  keyboardType: TextInputType.text,
                                  hintTextColor: AppColor.grey,
                                  len: 16,
                                  controller: userController.newPassword,
                                  obscure: userController.passwordObscure.value,
                                  iconData: userController.passwordObscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  iconTap: () => userController.passwordObscure.value =
                                  !userController.passwordObscure.value,
                                  validator: (val) => val!.length >= 6
                                      ? null
                                      : 'Should have minimum 6 characters',
                                ),
                              ),
                              Obx(
                                    () => TitleTextField(
                                  title: 'Confirm New Password',
                                  hint: 'Confirm New Password',
                                  cursorColor: AppColor.black,
                                  textColor: AppColor.black,
                                  keyboardType: TextInputType.text,
                                  hintTextColor: AppColor.grey,
                                  len: 16,
                                  controller: userController.confirmNewPassword,
                                  obscure: userController.confirmPasswordObscure.value,
                                  iconData: userController.confirmPasswordObscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  iconTap: () =>
                                  userController.confirmPasswordObscure.value =
                                  !userController.confirmPasswordObscure.value,
                                  validator: (val) => val!.length >= 6
                                      ? null
                                      : 'Should have minimum 6 characters',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),)
                  ],
                )
            ),
            bottomNavigationBar: SizedBox(
              height: ScreenSize.height(context)*0.075,
              child: CostButton(
                buttonText: 'UPDATE',
                onTap: (){userController.changePasswordForgotPassword();}
              ),
            ),
          ),
        ),
      ),
    );
  }
}
