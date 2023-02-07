import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/app_images.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/cost_item_controller.dart';
import 'package:cost_admin/controllers/forum_controller.dart';
import 'package:cost_admin/controllers/launch_controller.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:cost_admin/controllers/purchase_controller.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/models/cost_items.dart';
import 'package:cost_admin/models/forum.dart';
import 'package:cost_admin/models/purchases.dart';
import 'package:cost_admin/views/home_main/home_main_pages/forum_screen_sub/discussion_screen.dart';
import 'package:cost_admin/views/home_main/home_main_pages/trade_screen_sub/add_or_update_cost_item.dart';
import 'package:cost_admin/views/home_main/home_main_pages/trade_screen_sub/chat_screen.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/app_buttons.dart';
import 'package:cost_admin/widgets/dialogs.dart';
import 'package:cost_admin/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'forum_screen_sub/add_or_edit_forum.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.white,
          body: GetBuilder(
            init: CostItemsController(),
            builder: (_) => NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          floating: true,
                          stretch: false,
                          //pinned: false,
                          toolbarHeight: 75,
                          leading: Container(),
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              color: AppColor.white,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      height: 0,
                                      decoration: const BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Center(
                                                  child: Text(
                                                "Forum",
                                                style: TextStyle(
                                                    color: AppColor.blackMild,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              width: ScreenSize.width(context) *
                                                  0.75,
                                              child: Divider(
                                                thickness: 2,
                                                color: AppColor.blackMild
                                                    .withOpacity(0.4),
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
                          expandedHeight: 110,
                          collapsedHeight: 75,
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(0),
                            child: Column(
                              children: [
                                ///TAB BARS
                                Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TabBar(
                                          labelPadding: EdgeInsets.only(
                                              left: ScreenSize.width(context) *
                                                  0.05,
                                              right: ScreenSize.width(context) *
                                                  0.05),
                                          indicatorWeight: 2.0,
                                          //controller: _tabController,
                                          indicatorColor: AppColor.blackMild,
                                          isScrollable: true,
                                          labelStyle: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          labelColor: AppColor.primaryColor,
                                          unselectedLabelColor: AppColor.grey,
                                          mouseCursor: SystemMouseCursors.none,
                                          onTap: (tab) {},
                                          tabs: const [
                                            Tab(
                                              text: 'MY FEED',
                                            ),
                                            Tab(
                                              text: 'MY POSTS',
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),

                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ))
                  ];
                },
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    myFeed(),
                    myPosts(),
                  ],
                )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => AddOrUpdateForum(newItem: true));
            },
            tooltip: "Add New Discussion",
            backgroundColor: AppColor.primaryColor,
            child: const Icon(
              Icons.add,
              color: AppColor.white,
            ),
          ),
        ),
      ),
    );
  }

  ///MY FEED
  Widget myFeed() {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: forumController.forumService.getAllForums(),
        builder: (context, snapshot) {
          //var orderItems = snapshot.data?.docs;
          if (snapshot.data?.docs.length == 0) {
            return const NoForumsPostedErrorPage();
          }

          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                      final forumItem = Forum.fromSnapshot(data!);

                      return ListBodyForForumItem(forumItem: forumItem,docId: data.id,);
                    },
                    childCount: snapshot.data?.docs.length,
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 40),
                ),
              ],
            );
          }

          return const ShimmerPage();
        },
      ),
    );
  }

  ///MY POSTS
  Widget myPosts() {
    return StreamBuilder<QuerySnapshot>(
      stream: forumController.forumService.getMyForumStream(),
      builder: (context, snapshot) {
        //var orderItems = snapshot.data?.docs;
        if (snapshot.data?.docs.length == 0) {
          return const NoForumsPostedErrorPage();
        }

        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                    final forumItem = Forum.fromSnapshot(data!);

                    return ListBodyForForumItem(forumItem: forumItem,docId: data.id,);
                  },
                  childCount: snapshot.data?.docs.length,
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 40),
              ),
            ],
          );
        }

        return const ShimmerPage();
      },
    );
  }
}

///LIST OF MY FORUM ITEMS
class ListBodyForForumItem extends StatefulWidget {
  ListBodyForForumItem({Key? key, required this.forumItem,required this.docId}) : super(key: key);
  Forum forumItem;
  String docId;

  @override
  State<ListBodyForForumItem> createState() => _ListBodyForForumItemState();
}

class _ListBodyForForumItemState extends State<ListBodyForForumItem> {
  late ExpandedTileController expandedController;

  @override
  void initState() {
    // initialize controller
    expandedController = ExpandedTileController(isExpanded: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Card(
          elevation: 10.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: ListBody(
            children: [
              //FORUM INFO - LIST TILE
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                child: ListTile(
                    shape: const Border(
                        bottom: BorderSide(
                            color: AppColor.greyShimmer,
                            style: BorderStyle.solid)),
                    leading: widget.forumItem.forumPostedByPhoto == ""
                        ? const Icon(Icons.book)
                        : Image.network(
                            widget.forumItem.forumPostedByPhoto,
                            fit: BoxFit.fill,
                            //height: ScreenSize.height(context) * 0.25,
                            width: 75,
                          ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: AutoSizeText(
                        widget.forumItem.forumHeadline,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: AutoSizeText(
                        'Posted by ${widget.forumItem.forumPostedByName} on ${DateFormat('hh:mm a').format(widget.forumItem.forumTimeStamp.toDate())}',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    trailing:
                    widget.forumItem.forumPostedByPhone == userController.profile!.phone ?
                    IconButton(
                      tooltip: "EDIT INFO",
                      icon: const Icon(
                        Icons.edit,
                        color: AppColor.primaryColor,
                      ),
                      onPressed: () {
                        //EDIT FORUM ITEM DETAILS
                        forumController.assignForumDataForUpdating(
                            forumItem: widget.forumItem);
                        Get.to(
                              () => AddOrUpdateForum(newItem: false,forumItems: widget.forumItem,docId: widget.docId,),
                          transition: Transition.rightToLeft,
                        );
                      },
                    ) : const SizedBox(height: 1,width: 1,)
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, top: 5),
                        //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                        child: RichText(
                          text: TextSpan(
                            text: widget.forumItem.forumDescription,
                            style: const TextStyle(
                                color: AppColor.blackMild,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  Get.to(() => DiscussionScreen(forumItem: widget.forumItem, docId: widget.docId));
                },
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  color: AppColor.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_comment_sharp,
                        color: AppColor.primaryColor,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "ADD DISCUSSION",
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      )
                    ],
                  ),
                ),
              )

              // ExpandedTile(
              //   // trailing: const Icon(
              //   //   Icons.arrow_forward_ios_outlined,
              //   //   size: 30,
              //   // ),
              //   theme: const ExpandedTileThemeData(
              //     headerColor: AppColor.white,
              //     headerRadius: 24.0,
              //     headerPadding: EdgeInsets.only(right: 20),
              //     headerSplashColor: AppColor.primaryColor,
              //     contentBackgroundColor: AppColor.white,
              //     contentPadding: EdgeInsets.all(0.0),
              //     contentRadius: 0.0,
              //   ),
              //   controller: expandedController,
              //   title: Padding(
              //     padding: const EdgeInsets.only(top: 8.0),
              //     child: Column(
              //       children: [
              //         // ///PHONE NUMBER
              //         // Row(
              //         //   mainAxisAlignment: MainAxisAlignment.start,
              //         //   children: [
              //         //     Expanded(
              //         //       child: Padding(
              //         //         padding: const EdgeInsets.only(
              //         //             left: 0, right: 0, bottom: 5, top: 2),
              //         //         //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
              //         //         child: RichText(
              //         //           text: TextSpan(
              //         //             text: 'PHONE NUMBER :',
              //         //             style: const TextStyle(
              //         //                 color: AppColor.grey,
              //         //                 fontSize: 15,
              //         //                 fontWeight: FontWeight.w400),
              //         //             children: <TextSpan>[
              //         //               TextSpan(
              //         //                 text:  ' ${ widget.costItems.phone}',
              //         //                 style: const TextStyle(
              //         //                     color: AppColor.black,
              //         //                     fontSize: 15,
              //         //                     fontWeight: FontWeight.w400),
              //         //               ),
              //         //             ],
              //         //           ),
              //         //         ),
              //         //       ),
              //         //     ),
              //         //   ],
              //         // ),
              //         //
              //         //
              //         // SizedBox(
              //         //   height: 5,
              //         // ),
              //         //
              //         // ///USER NAME
              //         // Row(
              //         //   mainAxisAlignment: MainAxisAlignment.start,
              //         //   children: [
              //         //     Expanded(
              //         //       child: Padding(
              //         //         padding: const EdgeInsets.only(
              //         //             left: 0, right: 0, bottom: 5, top: 2),
              //         //         //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
              //         //         child: RichText(
              //         //           text: TextSpan(
              //         //             text: 'USER NAME :',
              //         //             style: const TextStyle(
              //         //                 color: AppColor.grey,
              //         //                 fontSize: 15,
              //         //                 fontWeight: FontWeight.w400),
              //         //             children: <TextSpan>[
              //         //               TextSpan(
              //         //                 text:  ' ${ widget.costItems.userName}',
              //         //                 style: const TextStyle(
              //         //                     color: AppColor.black,
              //         //                     fontSize: 15,
              //         //                     fontWeight: FontWeight.w400),
              //         //               ),
              //         //             ],
              //         //           ),
              //         //         ),
              //         //       ),
              //         //     ),
              //         //   ],
              //         // ),
              //         //
              //         //
              //         //
              //         // SizedBox(
              //         //   height: 5,
              //         // ),
              //         //
              //         //
              //         // ///PASSWORD
              //         // Row(
              //         //   mainAxisAlignment: MainAxisAlignment.start,
              //         //   children: [
              //         //     Expanded(
              //         //       child: Padding(
              //         //         padding: const EdgeInsets.only(
              //         //             left: 0, right: 0, bottom: 5, top: 2),
              //         //         //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
              //         //         child: RichText(
              //         //           text: TextSpan(
              //         //             text:  'PASSWORD :',
              //         //             style: const TextStyle(
              //         //                 color: AppColor.grey,
              //         //                 fontSize: 15,
              //         //                 fontWeight: FontWeight.w400),
              //         //             children: <TextSpan>[
              //         //               TextSpan(
              //         //                 text: ' ${ widget.costItems.password}',
              //         //                 style: const TextStyle(
              //         //                     color: AppColor.black,
              //         //                     fontSize: 15,
              //         //                     fontWeight: FontWeight.w400),
              //         //               ),
              //         //             ],
              //         //           ),
              //         //         ),
              //         //       ),
              //         //     ),
              //         //   ],
              //         // ),
              //         //
              //         // SizedBox(
              //         //   height: 5,
              //         // ),
              //         //
              //         //
              //         // ///DRIVER STATUS
              //         // Row(
              //         //   mainAxisAlignment: MainAxisAlignment.start,
              //         //   children: [
              //         //     Expanded(
              //         //       child: Padding(
              //         //         padding: const EdgeInsets.only(
              //         //             left: 0, right: 0, bottom: 5, top: 2),
              //         //         //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
              //         //         child: RichText(
              //         //           text: TextSpan(
              //         //             text:  'DRIVER STATUS : ',
              //         //             style: const TextStyle(
              //         //                 color: AppColor.grey,
              //         //                 fontSize: 15,
              //         //                 fontWeight: FontWeight.w400),
              //         //             children: <TextSpan>[
              //         //               TextSpan(
              //         //                 text:  widget.costItems.status == true ? "Enabled" : "Disabled",
              //         //                 style: const TextStyle(
              //         //                     color: AppColor.black,
              //         //                     fontSize: 15,
              //         //                     fontWeight: FontWeight.w400),
              //         //               ),
              //         //             ],
              //         //           ),
              //         //         ),
              //         //       ),
              //         //     ),
              //         //   ],
              //         // ),
              //       ],
              //     ),
              //   ),
              //   content: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       // ///BLOOD GROUP
              //       // Row(
              //       //   mainAxisAlignment: MainAxisAlignment.start,
              //       //   children: [
              //       //     Expanded(
              //       //       child: Padding(
              //       //         padding: const EdgeInsets.only(
              //       //             left: 10, right: 0, bottom: 5, top: 2),
              //       //         //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
              //       //         child: RichText(
              //       //           text: TextSpan(
              //       //             text:  'BLOOD GROUP :',
              //       //             style: const TextStyle(
              //       //                 color: AppColor.grey,
              //       //                 fontSize: 15,
              //       //                 fontWeight: FontWeight.w400),
              //       //             children: <TextSpan>[
              //       //               TextSpan(
              //       //                 text:   ' ${ widget.costItems.bloodGroup}',
              //       //                 style: const TextStyle(
              //       //                     color: AppColor.black,
              //       //                     fontSize: 15,
              //       //                     fontWeight: FontWeight.w400),
              //       //               ),
              //       //             ],
              //       //           ),
              //       //         ),
              //       //       ),
              //       //     ),
              //       //   ],
              //       // ),
              //       //
              //       // SizedBox(
              //       //   height: 5,
              //       // ),
              //       //
              //       //
              //       // ///LICENSE IMAGE
              //       // Row(
              //       //   mainAxisAlignment: MainAxisAlignment.start,
              //       //   children: [
              //       //     Expanded(
              //       //       child: Padding(
              //       //         padding: const EdgeInsets.only(
              //       //             left: 10, right: 0, bottom: 10, top: 2),
              //       //         //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
              //       //         child: RichText(
              //       //           text: TextSpan(
              //       //             text:  'LICENSE IMAGE :',
              //       //             style: const TextStyle(
              //       //                 color: AppColor.grey,
              //       //                 fontSize: 15,
              //       //                 fontWeight: FontWeight.w400),
              //       //             children: <TextSpan>[
              //       //             ],
              //       //           ),
              //       //         ),
              //       //       ),
              //       //     ),
              //       //   ],
              //       // ),
              //       //
              //       //
              //       //
              //       // Center(
              //       //   child: Container(
              //       //     decoration: BoxDecoration(
              //       //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //       //     ),
              //       //     padding: const EdgeInsets.all(0.0),
              //       //     child: Column(
              //       //       children: [
              //       //         ClipRRect(
              //       //           //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) ),
              //       //           child:   widget.costItems.licenseImage.isEmpty
              //       //               ? Image.asset(
              //       //             AppImages.licenseDummy,
              //       //             height: ScreenSize.height(context) * 0.25,
              //       //             fit: BoxFit.fill,
              //       //           )
              //       //               : Image.network(
              //       //             widget.costItems.licenseImage,
              //       //             height: ScreenSize.height(context) * 0.25,
              //       //             width: ScreenSize.width(context) * 0.9,
              //       //             fit: BoxFit.fill,
              //       //           ),
              //       //         ),
              //       //       ],
              //       //     ),
              //       //   ),
              //       // ),
              //       //
              //       // ///VEHICLE INFO LABEL
              //       // Row(
              //       //   mainAxisAlignment: MainAxisAlignment.start,
              //       //   children: [
              //       //     Expanded(
              //       //       child: Padding(
              //       //         padding: const EdgeInsets.only(
              //       //             left: 10, right: 0, bottom: 5, top: 10),
              //       //         //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
              //       //         child: RichText(
              //       //           text: TextSpan(
              //       //             text:    'VEHICLE INFO :',
              //       //             style: const TextStyle(
              //       //                 color: AppColor.grey,
              //       //                 fontSize: 15,
              //       //                 fontWeight: FontWeight.w400),
              //       //             children: <TextSpan>[
              //       //             ],
              //       //           ),
              //       //         ),
              //       //       ),
              //       //     ),
              //       //   ],
              //       // ),
              //       //
              //       // Padding(
              //       //   padding: const EdgeInsets.only(top: 8.0),
              //       //   child: ListTile(
              //       //     shape: Border(
              //       //         bottom: BorderSide(
              //       //             color: AppColor.greyShimmer, style: BorderStyle.solid)),
              //       //     leading: ClipRRect(
              //       //         child: Image.asset(
              //       //           AppImages.jiffyFuelTruck,
              //       //           //width: 80,
              //       //           //height: 60,
              //       //           fit: BoxFit.fill,
              //       //         )
              //       //     ),
              //       //     title: Padding(
              //       //       padding: const EdgeInsets.only(left: 0),
              //       //       child: AutoSizeText(
              //       //         widget.costItems.vehicleNumber,
              //       //         maxLines: 1,
              //       //         style: const TextStyle(
              //       //           fontSize: 15,
              //       //           fontWeight: FontWeight.bold,
              //       //         ),
              //       //       ),
              //       //     ),
              //       //     subtitle: Row(
              //       //       mainAxisAlignment: MainAxisAlignment.start,
              //       //       children: [
              //       //         Flexible(
              //       //           child: Padding(
              //       //             padding: const EdgeInsets.only(left: 0, top: 5),
              //       //             //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
              //       //             child: RichText(
              //       //               maxLines: 1,
              //       //               text: TextSpan(
              //       //                 text:  'MODEL: ${ widget.costItems.vehicleModel} & CAP: ${ widget.costItems.vehicleCapacity}L',
              //       //                 style: const TextStyle(
              //       //                     color: AppColor.grey,
              //       //                     fontSize: 12,
              //       //                     fontWeight: FontWeight.w400),
              //       //                 children: <TextSpan>[
              //       //                 ],
              //       //               ),
              //       //             ),
              //       //           ),
              //       //         ),
              //       //       ],
              //       //     ),
              //       //
              //       //
              //       //   ),
              //       // ),
              //       //
              //       //
              //       // JiffyButton(buttonText: "REMOVE DRIVER", onTap: (){
              //       //   yesNoDialogOld(
              //       //     context,
              //       //     text: 'Do you want to remove the driver permanently?',
              //       //     onTap: () {
              //       //       Get.back();
              //       //       driverController.deleteDriver(
              //       //         driverUserName:  widget.costItems.userName,
              //       //         licenseUrl:  widget.costItems.licenseImage,
              //       //       );
              //       //     },
              //       //   );
              //       // }),
              //     ],
              //   ),
              //   onTap: () {
              //     //debugPrint("tapped!!");
              //   },
              //   onLongTap: () {
              //     //debugPrint("long tapped!!");
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

//ERROR PAGE - SHOWING NO COST ITEMS ADDED ERROR
class NoForumsPostedErrorPage extends StatelessWidget {
  const NoForumsPostedErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.message,
                size: 100,
                color: AppColor.primaryColor,
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 60),
                child: Text(
                  'NO DISCUSSIONS POSTED',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackMild),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
