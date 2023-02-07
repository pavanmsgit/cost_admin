import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/app_images.dart';
import 'package:cost_admin/const/screen_size.dart';







// titleAppBar() {
//   return PreferredSize(
//     preferredSize: Size.fromHeight(100.0),
//     child: AppBar(
//       backgroundColor: AppColor.primaryColor,
//       centerTitle: true,
//       title: Obx(()=>AutoSizeText(homeController.appBarTitles.elementAt(homeController.selectedTab.value)),),
//       elevation: 4,
//       bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(0.0),
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Obx(()=> AutoSizeText(homeController.appBarSubTitles.elementAt(homeController.selectedTab.value),style: TextStyle(color: AppColor.white,fontSize: 15,fontWeight: FontWeight.w400),)),
//           )),),
//   );
// }



appBarWithLogo() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50.0),
    child: AppBar(
      leading: Container(),
      backgroundColor: AppColor.primaryColor,
      centerTitle: true,
      title: Image.asset(AppImages.appLogoLight,
        height: 150,
        width: 150,
        fit: BoxFit.fill,
      ),
      elevation: 4,
    ),
  );
}



appBarWithLogoWithBackButton() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50.0),
    child: AppBar(
      backgroundColor: AppColor.primaryColor,
      centerTitle: true,
      title: Image.asset(AppImages.appLogoDark,
        height: 50,
        width: 100,
        fit: BoxFit.fill,
      ),
      elevation: 4,
    ),
  );
}








titleAppBarWithBackButton(String? title,String? subTitle) {
  return PreferredSize(
    preferredSize: Size.fromHeight(100.0),
    child: AppBar(
      leading:IconButton(
        //padding: EdgeInsets.only(top: ScreenSize.height(context) * 0.025),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColor.white,
          size: 30,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: AppColor.primaryColor,
      centerTitle: true,
      title: AutoSizeText(title ?? '',style: TextStyle(color: AppColor.white,fontSize: 15,fontWeight: FontWeight.bold),),
      elevation: 4,
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AutoSizeText(subTitle ?? '',style: TextStyle(color: AppColor.white,fontSize: 15,fontWeight: FontWeight.w400),),
          )),
    ),
  );
}




class SliverAppBarLogo extends StatelessWidget{
  SliverAppBarLogo({Key? key, this.title}) : super(key: key);
  String? title;

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      floating: false,
      stretch: false,
      //pinned: true,
      toolbarHeight: 50,
      leading: Container(),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: const EdgeInsets.only(bottom: 10),
          // It will cover 20% of our total height
          //height: ScreenSize.height(context) * 0.2,
          child: Stack(
            children: <Widget>[
              //THE TOP COLOR BAR
              Container(
                height: ScreenSize.height(context) * 0.01,
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 0),
                  height: 0,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: const Offset(0, 5),
                    //     blurRadius: 25,
                    //     color: AppColor.primaryColor.withOpacity(0.2),
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 5, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(bottom: 5),
                          child: Center(
                              child: Text(
                                title ?? "COST",
                                style: TextStyle(
                                    color: AppColor.blackMild,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ),
                        Container(
                          width: ScreenSize.width(context) * 0.75,
                          child: Divider(
                            height:
                            ScreenSize.height(context) * 0.01,
                            thickness: 2,
                            color:
                            AppColor.black.withOpacity(0.4),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      expandedHeight: 75,
      collapsedHeight: 50,
      backgroundColor: Colors.transparent,
      //pinned: false,
      elevation: 3.0,
    );
  }
}





class SliverAppBarLogoWithBackButton extends StatelessWidget{
  SliverAppBarLogoWithBackButton({Key? key, this.title}) : super(key: key);
  String? title;
  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      floating: false,
      stretch: false,
      //pinned: true,
      toolbarHeight: 50,
      leading: IconButton(
        padding: EdgeInsets.only(top: 10),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColor.blackMild,
          size: 25,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: const EdgeInsets.only(bottom: 10),
          // It will cover 20% of our total height
          //height: ScreenSize.height(context) * 0.2,
          child: Stack(
            children: <Widget>[
              //THE TOP COLOR BAR
              Container(
                height: ScreenSize.height(context) * 0.01,
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 0),
                  height: 0,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: const Offset(0, 5),
                    //     blurRadius: 25,
                    //     color: AppColor.primaryColor.withOpacity(0.2),
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 5, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(bottom: 5),
                          child: Center(
                              child: Text(
                                title ?? "COST",
                                style: TextStyle(
                                    color: AppColor.blackMild,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ),
                        Container(
                          width: ScreenSize.width(context) * 0.75,
                          child: Divider(
                            height:
                            ScreenSize.height(context) * 0.01,
                            thickness: 2,
                            color:
                            AppColor.black.withOpacity(0.4),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      expandedHeight: 75,
      collapsedHeight: 50,
      backgroundColor: Colors.transparent,
      //pinned: false,
      elevation: 3.0,
    );
  }
}


class SliverAppBarLogoWithExpandedImage extends StatelessWidget{
  const SliverAppBarLogoWithExpandedImage({Key? key,required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver:  SliverAppBar(
        floating: true,
        stretch: true,
        //pinned: true,
        toolbarHeight: 50,
        leading: Container(),
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            margin: const EdgeInsets.only(bottom: 0),
            // It will cover 20% of our total height
            //height: ScreenSize.height(context) * 0.2,
            child: Stack(
              children: <Widget>[
                //THE TOP COLOR BAR
                Container(
                  height: ScreenSize.height(context) * 0.01,
                  decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius:  BorderRadius.only(
                      bottomLeft:  Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    height: 0,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius:  BorderRadius.only(
                        bottomLeft:  Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     offset: const Offset(0, 5),
                      //     blurRadius: 25,
                      //     color: AppColor.primaryColor.withOpacity(0.2),
                      //   ),
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0,bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Center(
                                child: Text(
                                 "Header",
                                  style: TextStyle(color: AppColor.blackMild,fontWeight: FontWeight.bold,fontSize: 15),
                                )
                            ),
                          ),
                          Container(
                            width: ScreenSize.width(context)*0.75,
                            child: Divider(
                              height: ScreenSize.height(context) * 0.01,
                              thickness: 2,
                              color: AppColor.black.withOpacity(0.4),
                            ),
                          )
                        ],
                      ),
                    ),),
                ),
              ],
            ),
          ),
        ),
        expandedHeight: ScreenSize.height(context)*0.3,
        collapsedHeight: ScreenSize.height(context)*0.075,
        backgroundColor: Colors.transparent,
        pinned: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 0),
                margin: const EdgeInsets.only(top: 0),
                width: ScreenSize.width(context) * 1,
                decoration: const BoxDecoration(
                  color: AppColor.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child:  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.network(
                        image,
                        width: ScreenSize.width(context),
                        height: ScreenSize.height(context)*0.25,
                        fit: BoxFit.fill,
                        //cancelToken: cancellationToken,
                      ),
                    ),
                  ),),
              ),
            ),
          ),
        ),
      ),
    );




  }
}

class SliverAppBarLogoWithBackButtonAndExpandedImage extends StatelessWidget{
  const SliverAppBarLogoWithBackButtonAndExpandedImage({Key? key,required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      floating: false,
      stretch: false,
      toolbarHeight: ScreenSize.height(context) * 0.1,
      leading: IconButton(
        padding: EdgeInsets.only(top: ScreenSize.height(context) * 0.025),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColor.primaryColor,
          size: 30,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: const EdgeInsets.only(bottom: 0),
          // It will cover 20% of our total height
          //height: ScreenSize.height(context) * 0.2,
          child: Stack(
            children: <Widget>[
              //THE TOP COLOR BAR
              Container(
                height: ScreenSize.height(context) * 0.01,
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius:  BorderRadius.only(
                    bottomLeft:  Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  height: 0,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius:  BorderRadius.only(
                      bottomLeft:  Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: const Offset(0, 5),
                    //     blurRadius: 25,
                    //     color: AppColor.primaryColor.withOpacity(0.2),
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0,bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Center(
                              child: Text(
                                "Header",
                                style: TextStyle(color: AppColor.blackMild,fontWeight: FontWeight.bold,fontSize: 15),
                              )
                          ),
                        ),
                        Container(
                          width: ScreenSize.width(context)*0.75,
                          child: Divider(
                            height: ScreenSize.height(context) * 0.01,
                            thickness: 2,
                            color: AppColor.black.withOpacity(0.4),
                          ),
                        )
                      ],
                    ),
                  ),),
              ),

              Positioned(
                top: ScreenSize.height(context)*0.1,
                bottom: ScreenSize.height(context)*0.025,
                left: 0,
                right: 0,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.network(
                      image,
                      width: ScreenSize.width(context),
                      height: ScreenSize.height(context)*0.25,
                      fit: BoxFit.fill,
                      //cancelToken: cancellationToken,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      expandedHeight: ScreenSize.height(context)*0.3,
      backgroundColor: Colors.transparent,
      // bottom: PreferredSize(
      //   preferredSize: ,
      //   child: Text('HEY'),
      //
      // ),
    );
  }
}