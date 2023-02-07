import 'package:cost_admin/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/app_buttons.dart';
import 'package:cost_admin/widgets/loading_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
        init: UserController(),
        builder: (_) => Spinner(
          child: Form(
            key: userController.changePasswordFormKey,
            child: Scaffold(
              backgroundColor: AppColor.white,
              body: SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [

                   SliverAppBarLogoWithBackButton(title: "Change Password",),

                   SliverToBoxAdapter(child:Padding(
                     padding: const EdgeInsets.all(20),
                     child: ListBody(
                       children: [
                         Obx(
                               () => TitleTextField(
                             title: 'Current Password',
                             hint: 'Current Password',
                             cursorColor: AppColor.black,
                             textColor: AppColor.black,
                             keyboardType: TextInputType.text,
                             hintTextColor: AppColor.grey,
                             len: 16,
                             controller: userController.currentPassword,
                             obscure: userController.currentPasswordObscure.value,
                             iconData: userController.currentPasswordObscure.value
                                 ? Icons.visibility
                                 : Icons.visibility_off,
                             iconTap: () =>
                             userController.currentPasswordObscure.value =
                             !userController.currentPasswordObscure.value,
                             validator: (val) => val!.length >= 6
                                 ? null
                                 : 'Should have minimum 6 characters',
                                 onChanged: (val) => userController.updateTheUpdateButtonColor(),
                           ),
                         ),
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
                                 onChanged: (val) => userController.updateTheUpdateButtonColor(),
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
                                 onChanged: (val) => userController.updateTheUpdateButtonColor(),

                           ),
                         ),

                       ],
                     ),
                   ),)
                 ],
                )
              ),
              bottomNavigationBar: SizedBox(
                height: ScreenSize.height(context)*0.075,
                child: CostButton(
                  buttonText: 'SAVE',
                  buttonColor:  (userController.currentPasswordValidated.value == true || userController.passwordOneUpdated.value == true || userController.passwordTwoUpdated.value == true) ? AppColor.primaryColor : AppColor.grey,
                  onTap: (){userController.changePassword();},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
