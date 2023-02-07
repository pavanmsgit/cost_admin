///NEW FILE
///
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


List<News> newsFromJson(str) => List<News>.from((str).map((x) => News.fromJson(x.data())));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class News {
  News({
    required this.newsId,
    required this.newsDescription,
    required this.newsImage,
    required this.newsLink,
    required this.newsLinkExists,
    required this.newsDate,
    required this.status,
  });

  String newsId;
  String newsDescription;
  String newsImage;
  String newsLink;
  bool newsLinkExists;
  bool status;
  Timestamp newsDate;




  factory News.fromJson(Map<String, dynamic> json) => News(
    newsId: json["news_id"],
    newsDescription: json["news_description"],
    newsImage: json["news_image"],
    newsLink: json["news_link"],
    newsLinkExists: json["news_link_exists"],
    newsDate: json["news_date"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "news_id": newsId,
    "news_description": newsDescription,
    "news_image": newsImage,
    "news_link": newsLink,
    "news_link_exists": newsLinkExists,
    "status": status,
    "news_date": newsDate,
  };
}
