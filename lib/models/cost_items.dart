import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<CostItems> costItemsFromJson(str) =>
    List<CostItems>.from((str).map((x) => CostItems.fromJson(x.data())));

String costItemsToJson(List<CostItems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CostItems {
  var reference;

  CostItems({
    required this.costItemId,
    required this.costItemStatus,
    required this.costItemTimestamp,
    required this.costItemHeadline,
    required this.costItemPhoto,
    required this.costItemDescription,
    required this.costItemPrice,
    required this.costItemPostedByName,
    required this.costItemPostedByPhone,
    required this.costItemType,
    required this.costItemCoordinates,
    required this.costItemAddress,

  });

  //COST ITEM INFO
  late String costItemId;
  late int costItemStatus;
  late Timestamp costItemTimestamp;
  late String costItemHeadline;
  late String costItemPhoto;
  late String costItemDescription;
  late var costItemPrice;
  late String costItemPostedByName;
  late String costItemPostedByPhone;
  late int costItemType;

  late GeoPoint costItemCoordinates;
  late String costItemAddress;

  factory CostItems.fromJson(Map<String, dynamic> json) => CostItems(
        costItemId: json['costItemId'],
        costItemStatus: json['costItemStatus'],
        costItemTimestamp: json['costItemTimestamp'],
        costItemHeadline: json['costItemHeadline'],
        costItemPhoto: json['costItemPhoto'],
        costItemDescription: json['costItemDescription'],
        costItemPrice: json['costItemPrice'],
        costItemPostedByName: json['costItemPostedByName'],
        costItemPostedByPhone: json['costItemPostedByPhone'],
        costItemType: json['costItemType'],
    costItemCoordinates: json['costItemCoordinates'],
    costItemAddress: json['costItemAddress'],
      );

  Map<String, dynamic> toJson() => {
        'costItemId': costItemId,
        'costItemStatus': costItemStatus,
        'costItemTimestamp': costItemTimestamp,
        'costItemHeadline': costItemHeadline,
        'costItemPhoto': costItemPhoto,
        'costItemDescription': costItemDescription,
        'costItemPrice': costItemPrice,
        'costItemPostedByName': costItemPostedByName,
        'costItemPostedByPhone': costItemPostedByPhone,
        'costItemType': costItemType,
        'costItemCoordinates': costItemCoordinates,
        'costItemAddress': costItemAddress,
      };

  CostItems.fromMap(data, {this.reference}) {
    costItemId = data['costItemId']!;
    costItemStatus = data['costItemStatus']!;
    costItemTimestamp = data['costItemTimestamp'];
    costItemHeadline = data['costItemHeadline'];
    costItemPhoto = data['costItemPhoto'];
    costItemDescription = data['costItemDescription'];
    costItemPrice = data['costItemPrice'];
    costItemPostedByName = data['costItemPostedByName'];
    costItemPostedByPhone = data['costItemPostedByPhone'];
    costItemType = data['costItemType'];
    costItemCoordinates = data['costItemCoordinates'];
    costItemAddress = data['costItemAddress'];
  }

  CostItems.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}




class Bids {
  var reference;

  Bids({
    required this.bidId,
    required this.bidStatus,
    required this.bidTimestamp,
    required this.bidPostedByPhone,
    required this.bidAmount,
     this.bidPostedByName,
     this.bidPostedByAddress,
     this.bidPostedByEmail,
     this.bidPostedByCoordinates,
  });

  //COST ITEM INFO
  late String bidId;
  late int bidStatus;
  late var bidAmount;
  late Timestamp bidTimestamp;
  late String bidPostedByPhone;
  late String? bidPostedByName;
  late String? bidPostedByEmail;
  late String? bidPostedByAddress;
  late GeoPoint? bidPostedByCoordinates;


  factory Bids.fromJson(Map<String, dynamic> json) => Bids(
    bidId: json['bidId'],
    bidStatus: json['bidStatus'],
    bidTimestamp: json['bidTimestamp'],
    bidPostedByPhone: json['bidPostedByPhone'],
    bidAmount: json['bidAmount'],
    bidPostedByName: json['bidPostedByName'],
    bidPostedByAddress: json['bidPostedByAddress'],
    bidPostedByEmail: json['bidPostedByEmail'],
    bidPostedByCoordinates: json['bidPostedByCoordinates'],
  );

  Map<String, dynamic> toJson() => {
    'bidId': bidId,
    'bidStatus': bidStatus,
    'bidTimestamp': bidTimestamp,
    'bidPostedByPhone': bidPostedByPhone,
    'bidAmount': bidAmount,
    'bidPostedByName': bidPostedByName,
    'bidPostedByAddress': bidPostedByAddress,
    'bidPostedByEmail': bidPostedByEmail,
    'bidPostedByCoordinates': bidPostedByCoordinates,
  };

  Bids.fromMap(data, {this.reference}) {
    bidId = data['bidId']!;
    bidStatus = data['bidStatus']!;
    bidTimestamp = data['bidTimestamp'];
    bidPostedByPhone = data['bidPostedByPhone'];
    bidAmount = data['bidAmount'];
    bidPostedByName = data['bidPostedByName'];
    bidPostedByEmail = data['bidPostedByEmail'];
    bidPostedByAddress = data['bidPostedByAddress'];
    bidPostedByCoordinates = data['bidPostedByCoordinates'];
  }

  Bids.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
