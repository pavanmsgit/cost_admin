import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/models/news.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cost_admin/const/phone_auth_user_data.dart';


class NewsService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  String phone = UserData().getUserPhone();

  ///GETS ALL NEWS RESPONSE - ADDED BY ADMIN
  ///GETS LATEST 50 NEWS ITEMS
  Future allNews() async {
    var res = await firebaseFirestore
        .collection('news')
        .orderBy("news_date", descending: true)
        .limit(50)
        .get();

    print(res.docs.length);
    return newsFromJson(res.docs);
  }
}
