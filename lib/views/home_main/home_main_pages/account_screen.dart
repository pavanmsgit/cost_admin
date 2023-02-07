import 'package:cost_admin/controllers/launch_controller.dart';
import 'package:cost_admin/views/home_main/home_main_pages/account/change_password.dart';
import 'package:cost_admin/views/home_main/home_main_pages/account/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/views/home_main/home_main_pages/manage_marketplace_screen.dart';
import 'package:cost_admin/views/home_main/home_main_pages/history_screen.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/dialogs.dart';
import 'package:cost_admin/widgets/loading_widget.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userController.getUserProfile();
    });
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
                SliverAppBarLogo(title: "My Account",),

                SliverToBoxAdapter(
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    elevation: 3.0,
                    child: ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      //tileColor: AppColor.primaryColor.withOpacity(0.2),
                      horizontalTitleGap: 20,
                      leading: userController.profile!.profileImage == "" ? Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child:  const Icon(
                            Icons.person,
                            size: 50,
                            color: AppColor.white,
                          )
                        ),
                      ) : Container(
                        color: AppColor.white,
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child:  Image.network(
                              userController.profile!.profileImage,
                              height: ScreenSize.height(context) * 0.1,
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                      title: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                            child: Text(
                              userController.profile!.name,
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),

                      subtitle: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 5),
                              child: Text(
                                "${userController.profile!.phone}     ${userController.profile!.email}",
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),

                      trailing: IconButton(
                        icon: const Icon(Icons.edit,color: AppColor.primaryColor,),
                        onPressed: () {
                          Get.to(
                                () =>const UpdateProfile(),
                          );
                        }
                      ),
                    ),
                  ),
                ),

                //LIST OF OPTIONS
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),


                      AccountTile(
                        iconData: Icons.history,
                        //iconColor: AppColor.primaryColor,
                        title: 'MY PURCHASES',
                        onTap: () {
                          Get.to(
                                () =>  HistoryScreen(showButton: true,),
                          );
                        },
                      ),

                      //MANAGE MARKETPLACE
                      AccountTile(
                        iconData: Icons.price_change_rounded,
                        title: 'MANAGE MARKETPLACE',
                        onTap: () {
                          Get.to(
                                () => ManageMarketPlace(showButton: true,),
                          );
                        },
                      ),



                      AccountTile(
                        iconData: Icons.lock,
                        //iconColor: AppColor.primaryColor,
                        title: 'Change Password',
                        onTap: () => Get.to(
                              () => const ChangePasswordScreen(),
                        ),
                      ),


                      AccountTile(
                          iconData: Icons.report,
                          title: 'Report An Issue',
                          onTap: () {
                            launchController.launchEmailForReportAnIssue();
                          }
                      ),


                      AccountTile(
                        iconData: Icons.help,
                        title: 'Help',
                        onTap: () {
                          launchController.launchEmailForHelp();
                        }
                      ),

                      AccountTile(
                        iconData: Icons.logout,
                        //iconColor: AppColor.red,
                        title: 'Logout',
                        onTap: () {
                          yesNoDialog(
                            context,
                            'Do you want to logout?',
                                (){userController.logoutUser();},
                          );
                        },
                      ),

                      // AccountTile(
                      //   iconData: Icons.delete,
                      //   //iconColor: AppColor.red,
                      //   title: 'Delete Account',
                      //   onTap: () {
                      //     yesNoDialog(
                      //         context,
                      //         'Are you sure, you want to delete the account?',
                      //             (){userController.deleteUserAccount();});
                      //   },
                      // ),


                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key? key,
    required this.iconData,
    this.iconColor,
    required this.onTap,
    required this.title,

  }) : super(key: key);

  final IconData iconData;
  final Color? iconColor;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenSize.height(context) * 0.05,
        margin: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 6,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.0),
              blurRadius: 4,
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 5),
            Icon(
              iconData,
              color: iconColor ?? AppColor.black,
              size: 18,
            ),
            const SizedBox(width: 15),

            //TYPE 1
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: AppColor.black,
              ),
            ),

            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
