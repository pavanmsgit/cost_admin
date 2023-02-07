import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_admin/controllers/news_controller.dart';
import 'package:cost_admin/models/news.dart';
import 'package:flutter/material.dart';
import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/home_controller.dart';
import 'package:cost_admin/widgets/shimmer_widgets.dart';

class NewsCarouselWidget extends StatelessWidget {
  const NewsCarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: newsController.getNews(),
      builder: (ctx, snapshot) {
        return posterObjects(context);
      },
    );
  }
}

posterObjects(context) {
  List<News> posterList = newsController.news;

  final List<Widget> contentSliders = posterList
      .map(
        (item) => Card(
          color: AppColor.primaryColor,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  item.newsLink,
                  width: ScreenSize.width(context),
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width(context) * 0.8,
                  padding: const EdgeInsets.all(5.0),
                  child: AutoSizeText(
                    item.newsDescription,
                    maxLines: 2,
                    style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      .toList();

  return Container(
    padding: const EdgeInsets.only(top: 0),
    child: CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        aspectRatio: 2,
        enlargeCenterPage: true,
        disableCenter: false,
        scrollPhysics: const BouncingScrollPhysics(),
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
      ),
      items: contentSliders,
    ),
  );
}
