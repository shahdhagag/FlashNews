import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/api/api_manager.dart';
import 'package:newsapp/features/home/news/card_news.dart';
import 'package:newsapp/features/home/widgets/error_widget.dart';
import 'package:newsapp/features/home/widgets/loading_widget.dart';
import 'package:newsapp/models/news_response.dart';
import 'package:newsapp/models/source_response.dart';

class NewsWidegt extends StatefulWidget {
  const NewsWidegt({super.key, required this.sources});

  final Sources sources;

  @override
  State<NewsWidegt> createState() => _NewsWidegtState();
}

class _NewsWidegtState extends State<NewsWidegt> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse>(
      future: ApiManager(Dio())
          .getNewsBySourceId(widget.sources.id ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return MainErrorWidget(
            errorMsg: "Something went wrong.",
            onTryAgain: () {
              setState(() {});
            },
          );
        } else if (snapshot.data?.status != 'ok') {
          return MainErrorWidget(
            errorMsg: snapshot.data?.message ?? "Something went wrong.",
            onTryAgain: () {
              setState(() {});
            },
          );
        } else if (snapshot.data?.articles == null ||
            snapshot.data!.articles!.isEmpty) {
          return const Center(
            child: Text("No articles available."),
          );
        } else {
          var articleList = snapshot.data!.articles??[];

          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: articleList.length,
            itemBuilder: (context, index) {
              var article = articleList[index];

              return CardNews(article: article);
            },
          );
        }
      },
    );
  }
}
