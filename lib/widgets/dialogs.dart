import 'package:cost_admin/controllers/cost_item_controller.dart';
import 'package:cost_admin/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/screen_size.dart';



yesNoDialog(context, text, onTap) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
        content: Builder(
          builder: (context) {
            return SizedBox(
              height: ScreenSize.height(context) * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ScreenSize.height(context) * 0.05),
                  Row(
                    children: [
                      //NO BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: ScreenSize.height(context) * 0.055,
                            width: ScreenSize.width(context) * 0.28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: AppColor.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      //YES BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: onTap,
                          child: Container(
                            height: ScreenSize.height(context) * 0.055,
                            // width: width(context) * 0.32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: AppColor.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      );
    },
  );
}






postBidDialog(context, onTap) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
        content: Builder(
          builder: (context) {
            return SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Please enter the Bid amount in Rupees",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ScreenSize.height(context) * 0.05),

                  TitleTextField(
                    title: 'Enter Bid Amount',
                    hint: 'Enter Bid Amount',
                    len: 10,
                    cursorColor:AppColor.primaryColor,
                    icon: const Icon(Icons.money_rounded,color: AppColor.primaryColor,),
                    controller: costItemsController.bidAmountController,
                    keyboardType: TextInputType.number,
                    node: costItemsController.bidAmountNode,
                    onSubmit: (val) => costItemsController.bidAmountNode.unfocus(),
                  ),

                  SizedBox(height: ScreenSize.height(context) * 0.05),

                  Row(
                    children: [
                      //NO BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: ScreenSize.height(context) * 0.055,
                            width: ScreenSize.width(context) * 0.28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: AppColor.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      //YES BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: onTap,
                          child: Container(
                            height: ScreenSize.height(context) * 0.055,
                            // width: width(context) * 0.32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: AppColor.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Post',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      );
    },
  );
}





