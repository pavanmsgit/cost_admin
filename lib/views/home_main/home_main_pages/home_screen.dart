import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/controllers/purchase_controller.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:cost_admin/views/home_main/home_main_pages/trade_screen_sub/view_bids.dart';
import 'package:cost_admin/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/location_controller.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/posters.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cost_admin/controllers/cost_item_controller.dart';
import 'package:cost_admin/models/cost_items.dart';
import 'package:cost_admin/widgets/shimmer_widgets.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:intl/intl.dart';

import '../../../widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ///TAKING LOCATION PERMISSION AND ACCESSING LOCATION
      locationController.getLocationPermission();
      locationController.getLatestAddress().whenComplete(() => true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Spinner(
        child: Scaffold(
          body: GetBuilder(
            init: UserController(),
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
                      //pinned: true,
                      toolbarHeight: 250,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
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
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Center(
                                              child: Text(
                                            "Home",
                                            style: TextStyle(
                                                color: AppColor.blackMild,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )),
                                        ),
                                        SizedBox(
                                          width:
                                              ScreenSize.width(context) * 0.75,
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
                      expandedHeight: 300,
                      collapsedHeight: 250,
                      backgroundColor: Colors.transparent,
                      pinned: false,
                      elevation: 10.0,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(75),
                        child: Column(
                          children: [
                            ///NEWS CAROUSEL WIDGET
                            const NewsCarouselWidget(),

                            SizedBox(
                              width: ScreenSize.width(context) * 0.75,
                              child: Divider(
                                height: ScreenSize.height(context) * 0.01,
                                thickness: 2,
                                color: AppColor.blackMild.withOpacity(0.4),
                              ),
                            ),

                            ///TAB BARS
                            Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TabBar(
                                      labelPadding: EdgeInsets.only(
                                          left:
                                              ScreenSize.width(context) * 0.05,
                                          right:
                                              ScreenSize.width(context) * 0.05),
                                      indicatorWeight: 2.0,
                                      //controller: _tabController,
                                      indicatorColor: AppColor.primaryColor,
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
                                          text: 'COINS',
                                        ),
                                        Tab(
                                          text: 'STAMPS',
                                        ),
                                        Tab(
                                          text: 'AUCTION',
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
                    ),
                  )
                ];
              },
              body: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  coinItems(),
                  stampItems(),
                  auctionItems(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget coinItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: costItemsController.costItemsService.getAllCoinItemsStream(),
      builder: (context, snapshot) {
        //var orderItems = snapshot.data?.docs;
        if (snapshot.data?.docs.length == 0) {
          return const NoMyCostItemsErrorPage();
        }

        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                    final costItem = CostItems.fromSnapshot(data!);

                    return ListBodyForCostItem(costItems: costItem);
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

  Widget stampItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: costItemsController.costItemsService.getAllStampItemsStream(),
      builder: (context, snapshot) {
        if (snapshot.data?.docs.length == 0) {
          return const NoMyCostItemsErrorPage();
        }

        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                    final costItem = CostItems.fromSnapshot(data!);

                    return ListBodyForCostItem(costItems: costItem);
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

  Widget auctionItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: costItemsController.costItemsService.getAllAuctionItemsStream(),
      builder: (context, snapshot) {
        //var orderItems = snapshot.data?.docs;
        if (snapshot.data?.docs.length == 0) {
          return const NoMyCostItemsErrorPage();
        }

        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                    final costItem = CostItems.fromSnapshot(data!);

                    return ListBodyForCostItem(costItems: costItem);
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

class ListBodyForCostItem extends StatefulWidget {
  ListBodyForCostItem({Key? key, required this.costItems}) : super(key: key);
  CostItems costItems;

  @override
  State<ListBodyForCostItem> createState() => _ListBodyForCostItemState();
}

class _ListBodyForCostItemState extends State<ListBodyForCostItem> {
  ///HAVERSINE OBJECT
  final haversineDistance = HaversineDistance();
  late ExpandedTileController expandedController;

  @override
  void initState() {
    // initialize controller
    expandedController = ExpandedTileController(isExpanded: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final startCoordinate = Location(
        locationController.lat ?? 0.00, locationController.lang ?? 0.00);
    final endCoordinate = Location(
        widget.costItems.costItemCoordinates.latitude,
        widget.costItems.costItemCoordinates.longitude);
    var totalDistance = haversineDistance
        .haversine(startCoordinate, endCoordinate, Unit.KM)
        .toPrecision(2);

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Stack(
          children: [
            Card(
              elevation: 10.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: ListBody(
                children: [
                  Stack(
                    children: [
                      ///ITEM PHOTO
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: AppColor.white,
                        ),
                        child: Image.network(
                          widget.costItems.costItemPhoto,
                          fit: BoxFit.fill,
                          //height: ScreenSize.height(context) * 0.25,
                          width: ScreenSize.width(context) * 0.9,
                        ),
                      ),

                      ///PRICE
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0, top: 5, bottom: 5),
                          decoration: const BoxDecoration(
                            color: AppColor.blackMild,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: AutoSizeText(
                            widget.costItems.costItemType == 2
                                ? "Base Price Rs.${widget.costItems.costItemPrice}"
                                : "Rs.${widget.costItems.costItemPrice}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColor.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///COST ITEM INFO - LIST TILE
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                    child: ListTile(
                      shape: const Border(
                          bottom: BorderSide(
                              color: AppColor.greyShimmer,
                              style: BorderStyle.solid)),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: AutoSizeText(
                          widget.costItems.costItemHeadline,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 0, top: 5),
                        //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            text: widget.costItems.costItemDescription,
                            style: const TextStyle(
                                color: AppColor.blackMild,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[],
                          ),
                        ),
                      ),

                      ///PURCHASE BUTTON
                      trailing: widget.costItems.costItemType == 2
                          ? GestureDetector(
                              onTap: () {
                                postBidDialog(context, () {
                                  costItemsController.placeBid(
                                      costItem: widget.costItems);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                decoration: const BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: const AutoSizeText(
                                  "PLACE A BID",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                yesNoDialog(context,
                                    "Do you want to purchase this item ?", () {
                                  purchaseController.purchaseItem(
                                      costItem: widget.costItems);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                decoration: const BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: const AutoSizeText(
                                  "PURCHASE",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white),
                                ),
                              ),
                            ),
                    ),
                  ),

                  widget.costItems.costItemType == 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //VIEW MY BID
                            GestureDetector(
                              onTap: (){
                                Get.to(()=> ViewsBidsScreen(costItems: widget.costItems,));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10, top: 5),
                                //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                                child: RichText(
                                  textAlign: TextAlign.right,
                                  text: const TextSpan(
                                    text: 'VIEW MY BID',
                                    style:  TextStyle(
                                        color: AppColor.blackMild,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[],
                                  ),
                                ),
                              ),
                            ),
                            
                            //VIEW ALL BIDS
                            GestureDetector(
                              onTap: (){
                                Get.to(()=> ViewsBidsScreen(costItems: widget.costItems,));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10, top: 5),
                                //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                                child: RichText(
                                  textAlign: TextAlign.right,
                                  text: const TextSpan(
                                    text: 'VIEW ALL BIDS',
                                    style:  TextStyle(
                                        color: AppColor.blackMild,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),

                  ///USER INFO AND DATE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 0, bottom: 10, top: 5),
                          //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: 'Posted By ',
                              style: const TextStyle(
                                  color: AppColor.blackMild,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${widget.costItems.costItemPostedByName} on ${DateFormat('dd MMM yyyy').format(widget.costItems.costItemTimestamp.toDate())}',
                                  style: const TextStyle(
                                      color: AppColor.blackMild,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 15, bottom: 10, top: 5),
                        //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            text: '$totalDistance Kms Away',
                            style: const TextStyle(
                                color: AppColor.blackMild,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}







//ERROR PAGE - SHOWING NO COST ITEMS ADDED ERROR
class NoMyCostItemsErrorPage extends StatelessWidget {
  const NoMyCostItemsErrorPage({Key? key}) : super(key: key);

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
                Icons.monetization_on_outlined,
                size: 100,
                color: AppColor.primaryColor,
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 60),
                child: Text(
                  'NO COST ITEMS ADDED',
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
