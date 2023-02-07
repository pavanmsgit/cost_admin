import 'package:cost_admin/controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/phone_auth_user_data.dart';
import 'package:cost_admin/controllers/home_controller.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/widgets/bottom_nav.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/will_pop_bottom_sheet.dart';

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({Key? key}) : super(key: key);

  @override
  State<HomeScreenMain> createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  final HomeController hc = Get.put(HomeController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkPrefs();

      ///TAKING LOCATION PERMISSION AND ACCESSING LOCATION
      locationController.getLocationPermission();
      locationController.getLatestAddress().whenComplete(() => true);

      ///GETS USER PROFILE
      userController.getUserProfile();

      ///GETS TOP 50 NEWS FROM THE DATABASE
      newsController.getNews();
    });
    super.initState();
  }

  var phone;

  checkPrefs() async {
    phone = await UserData().getUserPhone();
    debugPrint("THIS IS USER PHONE NUMBER $phone");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: SafeArea(
        child: Spinner(
          child: Scaffold(
            //appBar: appBarWithLogo(),

            backgroundColor: AppColor.white,

            body: Obx(
              () => SafeArea(
                child: hc.screens.elementAt(hc.selectedTab.value),
              ),
            ),

            bottomNavigationBar: const AppBottomNav(),
          ),
        ),
      ),
    );
  }
}
