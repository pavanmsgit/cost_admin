import 'package:cost_admin/models/news.dart';
import 'package:cost_admin/services/news_service.dart';
import 'package:get/get.dart';


final NewsController newsController = Get.find<NewsController>();

class NewsController extends GetxController {
  List<News> news = [];
  NewsService newsService = NewsService();

  ///UPDATES LIST NEWS ITEM
  getNews() async {
    news = await newsService.allNews();
    update();
  }

}
