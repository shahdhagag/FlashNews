import 'package:newsApp/features/home/data/Repo/home_repo.dart';
import 'package:newsApp/models/news_response.dart';
import 'package:newsApp/models/source_response.dart';


class HomeRepoLocal extends HomeRepo {

  @override
  Future<SourceResponse> getSources(String categoryId) async {
    print(" Getting sources from LOCAL");

    return SourceResponse(
      status: "ok",
      sources: [],
    );
  }

  @override
  Future<NewsResponse> getNewsData(String sourceId) async {
    print(" Getting news from LOCAL");

    return NewsResponse(
      status: "ok",
      articles: [],
    );
  }
}
