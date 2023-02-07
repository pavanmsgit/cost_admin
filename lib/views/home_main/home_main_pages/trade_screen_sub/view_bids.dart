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

import '../forum_screen_sub/add_or_edit_forum.dart';


class ViewsBidsScreen extends StatefulWidget {
  ViewsBidsScreen({Key? key,required this.costItems}) : super(key: key);
  CostItems costItems;

  @override
  State<ViewsBidsScreen> createState() => _ViewsBidsScreenState();
}

class _ViewsBidsScreenState extends State<ViewsBidsScreen> {
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
                                                    "VIEW BIDS",
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
                                              text: 'MY BID',
                                            ),
                                            Tab(
                                              text: 'ALL BIDS',
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
                    myBid(),
                    allBids(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  ///MY FEED
  Widget myBid() {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: costItemsController.costItemsService.getMyBid(costItems: widget.costItems),
        builder: (context, snapshot) {
          //var orderItems = snapshot.data?.docs;
          if (snapshot.data?.docs.length == 0) {
            return const NoBidsPostedErrorPage();
          }

          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                      final bidItem = Bids.fromSnapshot(data!);

                      return ListBodyForBidsItem(bidsItem: bidItem,docId: data.id,costItems: widget.costItems,);
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
  Widget allBids() {
    return StreamBuilder<QuerySnapshot>(
      stream: costItemsController.costItemsService.getAllBids(costItems: widget.costItems),
      builder: (context, snapshot) {
        //var orderItems = snapshot.data?.docs;
        if (snapshot.data?.docs.length == 0) {
          return const NoBidsPostedErrorPage();
        }

        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                    final bidsItem = Bids.fromSnapshot(data!);

                    return ListBodyForBidsItem(bidsItem: bidsItem,docId: data.id,costItems: widget.costItems,);
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
class ListBodyForBidsItem extends StatefulWidget {
  ListBodyForBidsItem({Key? key, required this.bidsItem, required this.costItems,required this.docId}) : super(key: key);
  Bids bidsItem;
  CostItems costItems;
  String docId;

  @override
  State<ListBodyForBidsItem> createState() => _ListBodyForBidsItemState();
}

class _ListBodyForBidsItemState extends State<ListBodyForBidsItem> {
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
                    leading: widget.costItems.costItemPhoto == ""
                        ? const Icon(Icons.book)
                        : Image.network(
                      widget.costItems.costItemPhoto,
                      fit: BoxFit.fill,
                      //height: ScreenSize.height(context) * 0.25,
                      width: 75,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: AutoSizeText(
                        widget.costItems.costItemHeadline,
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
                        'Posted by ${widget.costItems.costItemPostedByName} on ${DateFormat('hh:mm a').format(widget.costItems.costItemTimestamp.toDate())}',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    trailing:
                    widget.bidsItem.bidPostedByPhone == userController.profile!.phone ?
                    IconButton(
                      tooltip: "EDIT INFO",
                      icon: const Icon(
                        Icons.edit,
                        color: AppColor.primaryColor,
                      ),
                      onPressed: () {
                        //EDIT BID DETAILS
                        postBidDialog(context, () {
                          costItemsController.placeBid(
                              costItem: widget.costItems);
                        });
                      },
                    ) : const SizedBox(height: 1,width: 1,)
                ),
              ),

              //BID AMOUNT
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, top: 5),
                        //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                        child: RichText(
                          text: TextSpan(
                            text: "BID AMOUNT IS ",
                            style: const TextStyle(
                                color: AppColor.blackMild,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[

                              TextSpan(
                                text: "RS. ${widget.bidsItem.bidAmount}",
                                style: const TextStyle(
                                    color: AppColor.blackMild,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0,top: 0.0),
                    child: AutoSizeText(
                      'Bid Posted by ${widget.bidsItem.bidPostedByPhone} on ${DateFormat('hh:mm a').format(widget.bidsItem.bidTimestamp.toDate())}',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.blackMild,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }
}

//ERROR PAGE - SHOWING NO COST ITEMS ADDED ERROR
class NoBidsPostedErrorPage extends StatelessWidget {
  const NoBidsPostedErrorPage({Key? key}) : super(key: key);

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
                  'NO BIDS POSTED',
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
