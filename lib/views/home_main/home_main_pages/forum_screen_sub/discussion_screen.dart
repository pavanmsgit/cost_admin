import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/controllers/forum_controller.dart';
import 'package:cost_admin/controllers/purchase_controller.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/models/forum.dart';
import 'package:cost_admin/models/purchases.dart';
import 'package:cost_admin/widgets/shimmer_widgets.dart';
import 'package:cost_admin/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/app_images.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/cost_item_controller.dart';
import 'package:cost_admin/controllers/launch_controller.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:cost_admin/controllers/purchase_controller.dart';
import 'package:cost_admin/models/cost_items.dart';
import 'package:cost_admin/models/purchases.dart';
import 'package:cost_admin/views/home_main/home_main_pages/trade_screen_sub/add_or_update_cost_item.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/dialogs.dart';
import 'package:cost_admin/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:intl/intl.dart';

import 'add_or_edit_forum.dart';

class DiscussionScreen extends StatefulWidget {
  DiscussionScreen({Key? key, required this.forumItem, required this.docId})
      : super(key: key);
  Forum forumItem;
  String docId;

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: GetBuilder(
          init: PurchaseController(),
          builder: (_) => NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBarLogoWithBackButton(
                      title: "Add Your Comment",
                    ))
              ];
            },
            body: forumDiscussionPage(),
          ),
        ),
        resizeToAvoidBottomInset: true,
        bottomSheet: Container(
          color: AppColor.primaryColor,
          padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
          height: 60,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: "Write Comment...",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none),
                  style: const TextStyle(color: AppColor.white),
                  controller: forumController.chatController,
                  cursorColor: AppColor.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              FloatingActionButton(
                onPressed: () {
                  forumController.addDiscussionToForum(
                      docId: widget.docId, forumItem: widget.forumItem);
                },
                backgroundColor: Colors.white,
                elevation: 0,
                child: const Icon(
                  Icons.send,
                  color: AppColor.primaryColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget forumDiscussionPage() {
    return StreamBuilder<QuerySnapshot>(
      stream: forumController.forumService
          .getForumDiscussionData(docId: widget.docId),
      builder: (context, snapshot) {
        //var orderItems = snapshot.data?.docs;
        if (snapshot.data?.docs.length == 0) {
          return const NoChats();
        }

        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              //FORUM INFO - LIST TILE
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                  child: ListTile(
                    shape: const Border(
                        bottom: BorderSide(
                            color: AppColor.greyShimmer,
                            style: BorderStyle.solid)),
                    leading: widget.forumItem.forumPostedByPhoto == ""
                        ? Icon(Icons.book)
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
                    trailing: IconButton(
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
                          () => AddOrUpdateForum(
                            newItem: false,
                            forumItems: widget.forumItem,
                            docId: widget.docId,
                          ),
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, top: 5),
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
              ),

              const SliverToBoxAdapter(
                child: Divider(
                  color: AppColor.primaryColor,
                  thickness: 1.0,
                ),
              ),

              SliverList(

                delegate: SliverChildBuilderDelegate(
                  addSemanticIndexes: true,


                  (BuildContext context, int index) {
                    QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                    final forumResponses = ForumResponses.fromSnapshot(data!);

                    return ListBodyForForumResponses(
                        forumResponses: forumResponses, docId: data.id);
                  },
                  childCount: snapshot.data?.docs.length,
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 75),
              ),
            ],
          );
        }

        return const ShimmerPage();
      },
    );
  }
}

///LIST OF PURCHASE REQUESTS
class ListBodyForForumResponses extends StatefulWidget {
  ListBodyForForumResponses(
      {Key? key, required this.forumResponses, required this.docId})
      : super(key: key);
  ForumResponses forumResponses;
  String docId;

  @override
  State<ListBodyForForumResponses> createState() =>
      _ListBodyForForumResponsesState();
}

class _ListBodyForForumResponsesState extends State<ListBodyForForumResponses> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ListBody(
        children: [
          ListTile(
            shape: const Border(
                bottom: BorderSide(
                    color: AppColor.greyShimmer, style: BorderStyle.solid)),
            leading: widget.forumResponses.senderPhoto == ""
                ? Icon(Icons.person)
                : Image.network(
                    widget.forumResponses.senderPhoto,
                    fit: BoxFit.fill,
                    //height: ScreenSize.height(context) * 0.25,
                    width: 75,
                  ),
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, bottom: 10, top: 5),
                    //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text:  widget.forumResponses.senderName,
                        style: const TextStyle(
                            color: AppColor.blackMild,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                            ' posted on ${DateFormat('hh:mm a').format(widget.forumResponses.forumResponseTimestamp.toDate())}',
                            style: const TextStyle(
                                color: AppColor.blackMild,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            subtitle: Container(
              color: AppColor.greyLight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: AutoSizeText(
                  widget.forumResponses.message,
                  maxLines: 30,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//ERROR PAGE - SHOWING NO COST ITEMS ADDED ERROR
class NoChats extends StatelessWidget {
  const NoChats({Key? key}) : super(key: key);

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
                Icons.comment,
                size: 100,
                color: AppColor.primaryColor,
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 60),
                child: Text(
                  'NO COMMENTS',
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
