import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cost_admin/const/app_images.dart';
import 'package:shimmer/shimmer.dart';
import '../const/app_colors.dart';
import '../const/screen_size.dart';


class ShimmerPage extends StatelessWidget {
  const ShimmerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColor.greyShimmer,
        highlightColor: AppColor.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Container(
              //       decoration: const BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //       ),
              //       margin: const EdgeInsets.only(left: 15,bottom: 10,top: 15),
              //       //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              //       height: ScreenSize.height(context)* 0.015,
              //       width: ScreenSize.width(context)* 0.5,
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 10,
              ),

              ///ONE
              Column(
                children: [
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    //tileColor: AppColor.primaryColor,
                    horizontalTitleGap: 10,
                    leading: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.15,
                      width: ScreenSize.width(context)* 0.15,
                    ),

                    title: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.02,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    subtitle: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.03,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    //trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){},),
                  ),
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                    ),
                    //tileColor: AppColor.primaryColor,
                    horizontalTitleGap: 10,


                    title: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.02,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    subtitle: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.03,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    //trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){},),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    margin: const EdgeInsets.only(top: 0),
                    //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    height: ScreenSize.height(context)* 0.075,
                    width: ScreenSize.width(context)* 0.95,
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              ///TWO
              Column(
                children: [
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    //tileColor: AppColor.primaryColor,
                    horizontalTitleGap: 10,
                    leading: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.15,
                      width: ScreenSize.width(context)* 0.15,
                    ),

                    title: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.02,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    subtitle: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.03,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    //trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){},),
                  ),
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                    ),
                    //tileColor: AppColor.primaryColor,
                    horizontalTitleGap: 10,


                    title: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.02,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    subtitle: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.03,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    //trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){},),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    margin: const EdgeInsets.only(top: 0),
                    //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    height: ScreenSize.height(context)* 0.075,
                    width: ScreenSize.width(context)* 0.95,
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              ///THREE
              Column(
                children: [
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    //tileColor: AppColor.primaryColor,
                    horizontalTitleGap: 10,
                    leading: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.15,
                      width: ScreenSize.width(context)* 0.15,
                    ),

                    title: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.02,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    subtitle: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.03,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    //trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){},),
                  ),
                  ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                    ),
                    //tileColor: AppColor.primaryColor,
                    horizontalTitleGap: 10,


                    title: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.02,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    subtitle: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: ScreenSize.height(context)* 0.03,
                      width: ScreenSize.width(context)* 0.75,
                    ),

                    //trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){},),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    margin: const EdgeInsets.only(top: 0),
                    //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    height: ScreenSize.height(context)* 0.075,
                    width: ScreenSize.width(context)* 0.95,
                  ),
                ],
              ),



            ],
          ),
        )
    );
  }
}



