import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/text_field.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:place_picker/widgets/place_picker.dart';



//UPDATE PROFILE
class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
        init: UserController(),
        builder: (_) => Scaffold(
          backgroundColor: AppColor.white,
          body: Spinner(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [

                SliverAppBarLogoWithBackButton(title: "Edit Profile",),

                SliverToBoxAdapter(
                  child: Form(
                    key: userController.updateProfileKey,
                    child: Column(
                      children: [

                        const SizedBox(
                          height: 10.0,
                        ),

                        if (userController.image == null && userController.imageUrl.isEmpty)
                          CircleAvatar(
                            backgroundColor: AppColor.primaryColor,
                            radius: ScreenSize.width(context) * 0.12,
                            // backgroundImage: FileImage(userController.image!),
                            child: Center(
                              child: GestureDetector(
                                onTap: userController.selectImage,
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        if (userController.imageUrl.isNotEmpty)
                          CircleAvatar(
                            backgroundColor: AppColor.primaryColor,
                            radius: ScreenSize.width(context) * 0.12,
                            backgroundImage: CachedNetworkImageProvider(
                                userController.imageUrl),
                            child: Center(
                              child: GestureDetector(
                                onTap: userController.selectImage,
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        if (userController.image != null)
                          CircleAvatar(
                            backgroundColor: AppColor.primaryColor,
                            radius: ScreenSize.width(context) * 0.12,
                            backgroundImage: FileImage(userController.image!),
                            child: Center(
                              child: GestureDetector(
                                onTap: userController.selectImage,
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                        const SizedBox(
                          height: 10.0,
                        ),

                        ///NAME
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0,top: 10),
                                child: const AutoSizeText('NAME :',style: TextStyle(color: AppColor.grey,fontWeight: FontWeight.bold),),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 0),
                                width: ScreenSize.width(context)*0.75,
                                child: TitleTextField(
                                  title: '',
                                  hint: 'Name',
                                  controller: userController.name,
                                ),
                              ),
                            ],
                          ),
                        ),


                        ///EMAIL
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0,top: 10),
                                child: const AutoSizeText('EMAIL :',style: const TextStyle(color: AppColor.grey,fontWeight: FontWeight.bold),),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 0),
                                width: ScreenSize.width(context)*0.75,
                                child: TitleTextField(
                                  title: '',
                                  hint: 'Email',
                                  controller: userController.email,
                                ),
                              ),
                            ],
                          ),
                        ),


                        ///PHONE NUMBER
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0,left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0,top: 10),
                                child: AutoSizeText('PHONE :',style: const TextStyle(color: AppColor.grey,fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,top: 10),
                                child: AutoSizeText(userController.profile!.phone,style: const TextStyle(color: AppColor.black,fontWeight: FontWeight.w400),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: ScreenSize.height(context) * 0.075,
            child: CostButton(
              onTap: userController.updateProfile,
              buttonText: 'UPDATE',
            ),
          ),
        ),
      ),
    );
  }
}
