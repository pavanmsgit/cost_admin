import 'package:flutter/material.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/app_images.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/phone_auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    phoneAuthController.checkAuth();
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColor.primaryColor,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(),
              Expanded(
                child: Center(
                  child: Image(
                    height: ScreenSize.height(context) * 0.5,
                    image: const AssetImage(
                      AppImages.appLogoDark,
                    ),
                  ),
                ),
              ),
              const Text(
                'COINS OR STAMPS TRADE',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
