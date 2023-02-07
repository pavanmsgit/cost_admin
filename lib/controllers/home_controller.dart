import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/views/home_main/home_main_pages/forum_screen.dart';
import 'package:get/get.dart';
import 'package:cost_admin/views/home_main/home_main_pages/account_screen.dart';
import 'package:cost_admin/views/home_main/home_main_pages/manage_marketplace_screen.dart';
import 'package:cost_admin/views/home_main/home_main_pages/home_screen.dart';
import 'package:cost_admin/views/home_main/home_main_pages/history_screen.dart';

final HomeController homeController = Get.find<HomeController>();

class HomeController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  RxInt selectedTab = 0.obs;

  List screens = [
    const HomeScreen(),
    ManageMarketPlace(showButton: false,),
    const ForumScreen(),
    HistoryScreen(showButton: false,),
    const AccountScreen(),
  ];

}
