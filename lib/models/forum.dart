import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Forum> forumFromJson(str) =>
    List<Forum>.from((str).map((x) => Forum.fromJson(x.data())));

String forumToJson(List<Forum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
  var reference;

  Forum({
    required this.forumId,
    required this.forumStatus,
    required this.forumHeadline,
    required this.forumDescription,
    required this.forumPostedByName,
    required this.forumPostedByPhone,
    required this.forumPostedByPhoto,
    required this.forumTimeStamp,
  });

  //COST ITEM INFO
  late String forumId;
  late int forumStatus;
  late String forumHeadline;
  late String forumDescription;
  late String forumPostedByName;
  late String forumPostedByPhone;
  late String forumPostedByPhoto;
  late Timestamp forumTimeStamp;

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        forumId: json['forumId'],
        forumStatus: json['forumStatus'],
        forumHeadline: json['forumHeadline'],
        forumDescription: json['forumDescription'],
        forumPostedByName: json['forumPostedByName'],
        forumPostedByPhone: json['forumPostedByPhone'],
        forumPostedByPhoto: json['forumPostedByPhoto'],
        forumTimeStamp: json['forumTimeStamp'],
      );

  Map<String, dynamic> toJson() => {
        'forumId': forumId,
        'forumStatus': forumStatus,
        'forumHeadline': forumHeadline,
        'forumDescription': forumDescription,
        'forumPostedByName': forumPostedByName,
        'forumPostedByPhone': forumPostedByPhone,
        'forumPostedByPhoto': forumPostedByPhoto,
        'forumTimeStamp': forumTimeStamp,
      };

  Forum.fromMap(data, {this.reference}) {
    forumId = data['forumId']!;
    forumStatus = data['forumStatus']!;
    forumHeadline = data['forumHeadline'];
    forumDescription = data['forumDescription'];
    forumPostedByName = data['forumPostedByName'];
    forumPostedByPhone = data['forumPostedByPhone'];
    forumPostedByPhoto = data['forumPostedByPhoto'];
    forumTimeStamp = data['forumTimeStamp'];
  }

  Forum.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}

class ForumResponses {
  var reference;

  ForumResponses({
    required this.forumResponseId,
    required this.senderName,
    required this.senderPhone,
    required this.senderPhoto,
    required this.forumId,
    required this.message,
    required this.forumResponseTimestamp,
  });

  //FORUM RESPONSE INFO
  late String forumResponseId;
  late String senderName;
  late String senderPhone;
  late String senderPhoto;
  late String forumId;
  late String message;
  late Timestamp forumResponseTimestamp;

  factory ForumResponses.fromJson(Map<String, dynamic> json) => ForumResponses(
        forumResponseId: json['forumResponseId'],
        senderName: json['senderName'],
        senderPhone: json['senderPhone'],
        senderPhoto: json['senderPhone'],
        forumId: json['forumId'],
        message: json['message'],
        forumResponseTimestamp: json['forumResponseTimestamp'],
      );

  Map<String, dynamic> toJson() => {
        'forumResponseId': forumResponseId,
        'senderName': senderName,
        'senderPhone': senderPhone,
        'senderPhoto': senderPhoto,
        'forumId': forumId,
        'message': message,
        'forumResponseTimestamp': forumResponseTimestamp,
      };

  ForumResponses.fromMap(data, {this.reference}) {
    forumResponseId = data['forumResponseId'];
    senderName = data['senderName'];
    senderPhone = data['senderPhone'];
    senderPhoto = data['senderPhoto'];
    forumId = data['forumId'];
    message = data['message'];
    forumResponseTimestamp = data['forumResponseTimestamp'];
  }

  ForumResponses.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
