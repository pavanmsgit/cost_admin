import 'package:cost_admin/controllers/forum_controller.dart';
import 'package:cost_admin/controllers/launch_controller.dart';
import 'package:cost_admin/controllers/news_controller.dart';
import 'package:cost_admin/controllers/purchase_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:cost_admin/controllers/cost_item_controller.dart';
import 'package:cost_admin/controllers/phone_auth_controller.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/firebase_options.dart';
import 'package:cost_admin/views/splash_screen.dart';
import 'package:cost_admin/widgets/will_pop_bottom_sheet.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  Get.put(PhoneAuthController());
  Get.put(UserController());
  Get.put(LocationController());
  Get.put(NewsController());
  Get.put(LaunchController());
  Get.put(CostItemsController());
  Get.put(PurchaseController());
  Get.put(ForumController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'COST ADMIN',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}








