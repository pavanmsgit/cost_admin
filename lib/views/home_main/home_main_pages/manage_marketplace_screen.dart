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
import 'package:cost_admin/views/home_main/home_main_pages/trade_screen_sub/chat_screen.dart';
import 'package:cost_admin/views/home_main/home_main_pages/trade_screen_sub/manage_bids.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/dialogs.dart';
import 'package:cost_admin/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ManageMarketPlace extends StatefulWidget {
  ManageMarketPlace({Key? key, required this.showButton}) : super(key: key);
  bool showButton;

  @override
  State<ManageMarketPlace> createState() => _ManageMarketPlaceState();
}

class _ManageMarketPlaceState extends State<ManageMarketPlace> {
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
                          leading: widget.showButton == true
                              ? IconButton(
                                  padding: EdgeInsets.only(top: 10),
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColor.blackMild,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                )
                              : Container(),
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
                                                "Manage Marketplace",
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
                                        Flexible(
                                          child: TabBar(
                                            labelPadding: EdgeInsets.only(
                                                left:
                                                    ScreenSize.width(context) *
                                                        0.05,
                                                right:
                                                    ScreenSize.width(context) *
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
                                            mouseCursor:
                                                SystemMouseCursors.none,
                                            onTap: (tab) {},
                                            tabs: const [
                                              Tab(
                                                text: 'MY MARKETPLACE',
                                              ),
                                              Tab(
                                                text: 'SOLD COST ITEMS',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),

                                const SizedBox(
                                  height: 10,
                                ),

                                ///INCOMING ORDERS TEXT
                                // Text(
                                //   'INCOMING ORDERS',
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.w500,
                                //     color: AppColor.blackMild
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ))
                  ];
                },
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    myCostItems(),
                    myPurchaseRequests(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  ///MY COST ITEMS
  Widget myCostItems() {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: costItemsController.costItemsService.getMyCostItemsStream(),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddOrUpdateCostItem(newItem: true));
        },
        tooltip: "Add to Marketplace",
        backgroundColor: AppColor.primaryColor,
        child: const Icon(
          Icons.add,
          color: AppColor.white,
        ),
      ),
    );
  }

  Widget myPurchaseRequests() {
    return StreamBuilder<QuerySnapshot>(
      stream: purchaseController.purchaseService.getPurchasesRequestStream(),
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
                    final purchaseItem = Purchases.fromSnapshot(data!);

                    return ListBodyForPurchaseRequest(
                        purchaseItem: purchaseItem, docId: data.id);
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

///LIST OF MY COST ITEMS
class ListBodyForCostItem extends StatefulWidget {
  ListBodyForCostItem({Key? key, required this.costItems}) : super(key: key);
  CostItems costItems;

  @override
  State<ListBodyForCostItem> createState() => _ListBodyForCostItemState();
}

class _ListBodyForCostItemState extends State<ListBodyForCostItem> {
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
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: ListBody(
            children: [
              Stack(
                children: [
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
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                      decoration: const BoxDecoration(
                        color: AppColor.blackMild,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 2.5, bottom: 2.5),
                      decoration: const BoxDecoration(
                        color: AppColor.blackMild,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: AutoSizeText(
                        costItemsController.getCostItemTypeLabel(
                            widget.costItems.costItemType),
                        // "Rs.${widget.costItems.costItemPrice}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white),
                      ),
                    ),
                  ),
                ],
              ),

              //COST ITEM INFO - LIST TILE
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                child: ListTile(
                  // shape: const Border(
                  //     bottom: BorderSide(
                  //         color: AppColor.greyShimmer,
                  //         style: BorderStyle.solid)),
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
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
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
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: ScreenSize.width(context) * 0.1,
                    child: Row(
                      children: [
                        Flexible(
                          child: IconButton(
                            tooltip: "EDIT INFO",
                            icon: const Icon(
                              Icons.edit,
                              color: AppColor.primaryColor,
                            ),
                            onPressed: () {
                              //EDIT COST ITEM DETAILS
                              costItemsController.assignCostItemDataForUpdating(
                                  costItem: widget.costItems);
                              Get.to(
                                () => AddOrUpdateCostItem(
                                  newItem: false,
                                  costItems: widget.costItems,
                                ),
                                transition: Transition.rightToLeft,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //MANAGE AUCTION
              widget.costItems.costItemType == 2
                  ? GestureDetector(
                      onTap: () {
                        Get.to(() => ManageBidsScreen(costItems: widget.costItems,));
                      },
                      child: Container(
                        height: 30,
                        color: AppColor.primaryColor,
                        child: const Center(
                          child: Text(
                            "MANAGE AUCTION",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColor.white),
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

///LIST OF PURCHASE REQUESTS
class ListBodyForPurchaseRequest extends StatefulWidget {
  ListBodyForPurchaseRequest(
      {Key? key, required this.purchaseItem, required this.docId})
      : super(key: key);
  Purchases purchaseItem;
  String docId;

  @override
  State<ListBodyForPurchaseRequest> createState() =>
      _ListBodyForPurchaseRequestState();
}

class _ListBodyForPurchaseRequestState
    extends State<ListBodyForPurchaseRequest> {
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
        widget.purchaseItem.purchaseByCoordinates.latitude,
        widget.purchaseItem.purchaseByCoordinates.longitude);
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
                          widget.purchaseItem.costItemPhoto,
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
                            "Rs.${widget.purchaseItem.costItemPrice}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColor.white),
                          ),
                        ),
                      ),

                      ///SOLD TAG
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0, top: 5, bottom: 5),
                          decoration: const BoxDecoration(
                            color: AppColor.blackMild,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: AutoSizeText(
                            "SOLD",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColor.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ExpandedTile(
                    trailingRotation: 0,

                    ///CHAT BUTTON
                    trailing: IconButton(
                      onPressed: () {
                        Get.to(() => ChatScreen(
                            isBuyer: false,
                            purchaseItem: widget.purchaseItem,
                            docId: widget.docId));
                      },
                      icon: const Icon(Icons.chat,
                          size: 25, color: AppColor.primaryColor),
                    ),
                    theme: const ExpandedTileThemeData(
                      headerColor: AppColor.white,
                      headerRadius: 24.0,
                      headerPadding: EdgeInsets.only(right: 20),
                      headerSplashColor: AppColor.primaryColor,
                      contentBackgroundColor: AppColor.white,
                      contentPadding: EdgeInsets.all(0.0),
                      contentRadius: 0.0,
                    ),
                    controller: expandedController,
                    title: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, bottom: 5, top: 2),
                              //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                              child: RichText(
                                text: TextSpan(
                                  text: 'BUYER NAME :',
                                  style: const TextStyle(
                                      color: AppColor.blackMild,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          " ${widget.purchaseItem.purchaseByName}",
                                      style: const TextStyle(
                                          color: AppColor.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 0, top: 5),
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            text: "( Tap for more details )",
                            style: const TextStyle(
                                color: AppColor.blackMild,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[],
                          ),
                        ),
                      ),

                      ///CALL BUTTON
                      trailing: IconButton(
                        tooltip: "CALL BUYER",
                        onPressed: () {
                          launchController.makePhoneCall(
                              phoneNumber: widget.purchaseItem.purchaseByPhone);
                        },
                        icon: const Icon(Icons.phone,
                            size: 25, color: AppColor.primaryColor),
                      ),
                    ),
                    content: Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///BUYER PHONE
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, bottom: 5, top: 2),
                                  //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'BUYER PHONE :',
                                      style: const TextStyle(
                                          color: AppColor.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              " ${widget.purchaseItem.purchaseByPhone}",
                                          style: const TextStyle(
                                              color: AppColor.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///BUYER EMAIL
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, bottom: 5, top: 2),
                                  //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'BUYER EMAIL :',
                                      style: const TextStyle(
                                          color: AppColor.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              " ${widget.purchaseItem.purchaseByEmail}",
                                          style: const TextStyle(
                                              color: AppColor.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///BUYER ADDRESS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, bottom: 5, top: 2),
                                  //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'BUYER ADDRESS :',
                                      style: const TextStyle(
                                          color: AppColor.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              " ${widget.purchaseItem.purchaseByAddress}",
                                          style: const TextStyle(
                                              color: AppColor.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///BUYER DISTANCE
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, bottom: 5, top: 5),
                                  //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'BUYER DISTANCE FROM YOU :',
                                      style: const TextStyle(
                                          color: AppColor.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " ${totalDistance} Kms Away",
                                          style: const TextStyle(
                                              color: AppColor.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      //debugPrint("tapped!!");
                    },
                    onLongTap: () {
                      //debugPrint("long tapped!!");
                    },
                  ),

                  ///COST ITEM INFO - LIST TILE
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 0.0, bottom: 10),
                    child: ListTile(
                      shape: const Border(
                          top: BorderSide(
                              color: AppColor.greyShimmer,
                              style: BorderStyle.solid),
                          bottom: BorderSide(
                              color: AppColor.greyShimmer,
                              style: BorderStyle.solid)),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 0, top: 5),
                        child: AutoSizeText(
                          widget.purchaseItem.costItemHeadline,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding:
                            const EdgeInsets.only(left: 0, top: 5, bottom: 5),
                        //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            text: widget.purchaseItem.costItemDescription,
                            style: const TextStyle(
                                color: AppColor.blackMild,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[],
                          ),
                        ),
                      ),

                      ///PURCHASE BUTTON
                      //trailing:
                    ),
                  ),

                  ///PURCHASE ID AND DATE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 0, bottom: 10, top: 5),
                          //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: 'Purchase ID : ',
                              style: const TextStyle(
                                  color: AppColor.blackMild,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${widget.purchaseItem.purchaseId} & Purchased on ${DateFormat('dd MMM yyyy').format(widget.purchaseItem.purchaseTimeStamp.toDate())}',
                                  style: const TextStyle(
                                      color: AppColor.blackMild,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
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
