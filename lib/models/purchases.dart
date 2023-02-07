import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Purchases> purchasesFromJson(str) =>
    List<Purchases>.from((str).map((x) => Purchases.fromJson(x.data())));

String purchasesToJson(List<Purchases> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Purchases {
  var reference;

  Purchases({
    required this.costItemId,
    required this.costItemStatus,
    required this.costItemHeadline,
    required this.costItemPhoto,
    required this.costItemDescription,
    required this.costItemPrice,
    required this.costItemPostedByName,
    required this.costItemPostedByPhone,
    required this.costItemType,
    required this.costItemCoordinates,
    required this.costItemAddress,

    required this.purchaseId,
    required this.purchaseByName,
    required this.purchaseByPhone,
    required this.purchaseByEmail,
    required this.purchaseByAddress,
    required this.purchaseByCoordinates,
    required this.purchaseTimeStamp,
  });

  //COST ITEM INFO
  late String costItemId;
  late int costItemStatus;
  late String costItemHeadline;
  late String costItemPhoto;
  late String costItemDescription;
  late var costItemPrice;
  late String costItemPostedByName;
  late String costItemPostedByPhone;
  late int costItemType;
  late GeoPoint costItemCoordinates;
  late String costItemAddress;

  late String purchaseId;
  late String purchaseByName;
  late String purchaseByPhone;
  late String purchaseByEmail;
  late String purchaseByAddress;
  late GeoPoint purchaseByCoordinates;
  late Timestamp purchaseTimeStamp;

  factory Purchases.fromJson(Map<String, dynamic> json) => Purchases(
    costItemId: json['costItemId'],
    costItemStatus: json['costItemStatus'],
    costItemHeadline: json['costItemHeadline'],
    costItemPhoto: json['costItemPhoto'],
    costItemDescription: json['costItemDescription'],
    costItemPrice: json['costItemPrice'],
    costItemPostedByName: json['costItemPostedByName'],
    costItemPostedByPhone: json['costItemPostedByPhone'],
    costItemType: json['costItemType'],
    costItemCoordinates: json['costItemCoordinates'],
    costItemAddress: json['costItemAddress'],

    purchaseId: json['purchaseId'],
    purchaseByName: json['purchaseByName'],
    purchaseByPhone: json['purchaseByPhone'],
    purchaseByEmail: json['purchaseByEmail'],
    purchaseByAddress: json['purchaseByAddress'],
    purchaseByCoordinates: json['purchaseByCoordinates'],
    purchaseTimeStamp: json['purchaseTimeStamp'],
  );

  Map<String, dynamic> toJson() => {
    'costItemId': costItemId,
    'costItemStatus': costItemStatus,
    'costItemHeadline': costItemHeadline,
    'costItemPhoto': costItemPhoto,
    'costItemDescription': costItemDescription,
    'costItemPrice': costItemPrice,
    'costItemPostedByName': costItemPostedByName,
    'costItemPostedByPhone': costItemPostedByPhone,
    'costItemType': costItemType,
    'costItemCoordinates': costItemCoordinates,
    'costItemAddress': costItemAddress,

    'purchaseId': purchaseId,
    'purchaseByName': purchaseByName,
    'purchaseByPhone': purchaseByPhone,
    'purchaseByEmail': purchaseByEmail,
    'purchaseByAddress': purchaseByAddress,
    'purchaseByCoordinates': purchaseByCoordinates,
    'purchaseTimeStamp': purchaseTimeStamp,
  };

  Purchases.fromMap(data, {this.reference}) {
    costItemId = data['costItemId']!;
    costItemStatus = data['costItemStatus']!;
    costItemHeadline = data['costItemHeadline'];
    costItemPhoto = data['costItemPhoto'];
    costItemDescription = data['costItemDescription'];
    costItemPrice = data['costItemPrice'];
    costItemPostedByName = data['costItemPostedByName'];
    costItemPostedByPhone = data['costItemPostedByPhone'];
    costItemType = data['costItemType'];
    costItemCoordinates = data['costItemCoordinates'];
    costItemAddress = data['costItemAddress'];

    purchaseId = data['purchaseId'];
    purchaseByName = data['purchaseByName'];
    purchaseByPhone = data['purchaseByPhone'];
    purchaseByEmail = data['purchaseByEmail'];
    purchaseByAddress = data['purchaseByAddress'];
    purchaseByCoordinates = data['purchaseByCoordinates'];
    purchaseTimeStamp = data['purchaseTimeStamp'];
  }

  Purchases.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}






class PurchasesChat {
  var reference;

  PurchasesChat({
    required this.chatId,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.message,
    required this.chatTimestamp,
  });

  //COST ITEM INFO
  late String chatId;
  late String senderName;
  late String senderPhone;
  late String receiverName;
  late String receiverPhone;
  late String message;
  late Timestamp chatTimestamp;



  factory PurchasesChat.fromJson(Map<String, dynamic> json) => PurchasesChat(
    chatId: json['chatId'],
    senderName: json['senderName'],
    senderPhone: json['senderPhone'],
    receiverName: json['receiverName'],
    receiverPhone: json['receiverPhone'],
    message: json['message'],
    chatTimestamp: json['chatTimestamp'],
  );

  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'senderName': senderName,
    'senderPhone': senderPhone,
    'receiverName': receiverName,
    'receiverPhone': receiverPhone,
    'message': message,
    'chatTimestamp': chatTimestamp,
  };

  PurchasesChat.fromMap(data, {this.reference}) {
    chatId = data['chatId'];
    senderName = data['senderName'];
    senderPhone = data['senderPhone'];
    receiverName = data['receiverName'];
    receiverPhone = data['receiverPhone'];
    message = data['message'];
    chatTimestamp = data['chatTimestamp'];
  }

  PurchasesChat.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
