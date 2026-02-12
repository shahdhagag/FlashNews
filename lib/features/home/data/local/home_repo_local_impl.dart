import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:newsApp/features/home/data/local/home_local_repo.dart';
import 'package:newsApp/models/news_response.dart';
import 'package:newsApp/models/source_response.dart';

import '../../../../core/utiles/hive_constants.dart';

@Injectable(as: HomeLocalRepo)
class HomeRepoLocal extends HomeLocalRepo {
  @override
  Future<void> saveSources(List<Sources> sources) async {
    var box = Hive.box<Sources>(HiveConstants.sourcesBox);
    for (var source in sources) {
      if (source.id != null) {
        await box.put(source.id, source);
      }
    }
  }

  @override
  Future<SourceResponse> getSources(String categoryId) async {
    var box = Hive.box<Sources>(HiveConstants.sourcesBox);
    /// Filter by category
    List<Sources> filtered = box.values
        .where((s) => s.category == categoryId)
        .toList();
    return SourceResponse(status: "ok", sources: filtered);
  }

  @override
  Future<NewsResponse> getNewsData(String sourceId) async {
    var box = Hive.box<Articles>(HiveConstants.newsbox);
    List<Articles> filtered = box.values
        .where((a) => a.source?.id == sourceId)
        .toList();

    return NewsResponse(status: "ok", articles: filtered);
  }

  @override
  Future<NewsResponse> searchNews(String query) async {
    var box = Hive.box<Articles>(HiveConstants.newsbox);
    final lowercaseQuery = query.toLowerCase();

    var results = box.values.where((article) {
      /// Check Title
      bool matchTitle =
          article.title?.toLowerCase().contains(lowercaseQuery) ?? false;

      /// Check Description
      bool matchDesc =
          article.description?.toLowerCase().contains(lowercaseQuery) ?? false;

      /// Check Content
      bool matchContent =
          article.content?.toLowerCase().contains(lowercaseQuery) ?? false;

      return matchTitle || matchDesc || matchContent;
    }).toList();

    return NewsResponse(status: "ok", articles: results);
  }

  @override
  Future<void> saveArticles(List<Articles> articles) async {
    var box = Hive.box<Articles>(HiveConstants.newsbox);
    for (var article in articles) {
      if (article.url != null) {
        await box.put(article.url, article);
      }
    }
  }
}
