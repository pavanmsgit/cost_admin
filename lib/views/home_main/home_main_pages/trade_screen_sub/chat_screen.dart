import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/controllers/purchase_controller.dart';
import 'package:cost_admin/controllers/user_controller.dart';
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

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key,required this.isBuyer ,required this.purchaseItem, required this.docId})
      : super(key: key);
  bool isBuyer;
  Purchases purchaseItem;
  String docId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
                      title: widget.isBuyer ?  "Chat with ${widget.purchaseItem.costItemPostedByName}" : "Chat with ${widget.purchaseItem.purchaseByName}",
                    ))
              ];
            },
            body: myPurchaseChatPage(),
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
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none),
                  style: const TextStyle(color: AppColor.white),
                  controller: purchaseController.chatController,
                  cursorColor: AppColor.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              FloatingActionButton(
                onPressed: () {

                   purchaseController.sendMessage(docId: widget.docId, purchaseItem: widget.purchaseItem, isBuyer: widget.isBuyer);

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

  Widget myPurchaseChatPage() {
    return StreamBuilder<QuerySnapshot>(
      stream: purchaseController.purchaseService
          .getPurchasesChatData(docId: widget.docId),
      builder: (context, snapshot) {
        //var orderItems = snapshot.data?.docs;
        if (snapshot.data?.docs.length == 0) {
          return const NoChats();
        }

        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                    final chatsItem = PurchasesChat.fromSnapshot(data!);

                    return ListBodyForPurchaseRequest(
                        purchaseChatItem: chatsItem, docId: data.id);
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

///LIST OF PURCHASE REQUESTS
class ListBodyForPurchaseRequest extends StatefulWidget {
  ListBodyForPurchaseRequest(
      {Key? key, required this.purchaseChatItem, required this.docId})
      : super(key: key);
  PurchasesChat purchaseChatItem;
  String docId;

  @override
  State<ListBodyForPurchaseRequest> createState() =>
      _ListBodyForPurchaseRequestState();
}

class _ListBodyForPurchaseRequestState
    extends State<ListBodyForPurchaseRequest> {
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
          Container(
            width: 1,
            alignment: widget.purchaseChatItem.senderPhone ==
                    userController.profile!.phone
                ? Alignment.topRight
                : Alignment.topLeft,
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5, bottom: 5),
            margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5, bottom: 5),
            decoration:  BoxDecoration(
              color: widget.purchaseChatItem.senderPhone ==
                  userController.profile!.phone
                  ? AppColor.primaryColor.withOpacity(0.5)
                  : AppColor.greyLight,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Text(
              widget.purchaseChatItem.message,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black),
            ),
          ),
          Container(
              alignment: widget.purchaseChatItem.senderPhone ==
                      userController.profile!.phone
                  ? Alignment.topRight
                  : Alignment.topLeft,
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 0, bottom: 0),
              margin: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 0, bottom: 0),
              decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
              child: Text(
                DateFormat('hh:mm a').format(widget.purchaseChatItem.chatTimestamp.toDate()),
                style: const TextStyle(fontSize: 10, color: AppColor.blackMild),
              ))
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
                Icons.message,
                size: 100,
                color: AppColor.primaryColor,
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 60),
                child: Text(
                  'NO MESSAGES',
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
