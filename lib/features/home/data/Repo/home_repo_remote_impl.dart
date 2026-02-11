import 'package:injectable/injectable.dart';
import 'package:newsApp/api/api_service.dart';
import 'package:newsApp/api/endpoints.dart';
import 'package:newsApp/features/home/data/Repo/home_repo.dart';
import 'package:newsApp/models/news_response.dart';
import 'package:newsApp/models/source_response.dart';

@Injectable(as: HomeRepo)
class HomeRepoRemoteImpl extends HomeRepo {
  @override
  Future<NewsResponse> getNewsData(String sourceId) async {
    try {
      final response = await ApiService.dio.get(
        EndPoints.newsApi,
        queryParameters: {"sources": sourceId},
      );

      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      return newsResponse;
    } catch (e) {
      throw Exception("Failed to fetch news");
    }
  }

  @override
  Future<SourceResponse> getSources(String categoryId) async {
    try {
      final response = await ApiService.dio.get(
        EndPoints.sourceApi,
        queryParameters: {"category": categoryId},
      );
      return SourceResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch sources');
    }
  }

  @override
  Future<NewsResponse> searchNews(String query) async {
    try {
      final response = await ApiService.dio.get(
        EndPoints.newsApi,
        queryParameters: {
          "q": query,
          "searchIn": "title,content",
          // Restricting search to title and content
        },
      );

      return NewsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to search news");
    }
  }
}
