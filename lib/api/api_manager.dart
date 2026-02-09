import 'package:dio/dio.dart';
import 'package:newsapp/api/api_constants.dart';
import 'package:newsapp/api/endpoints.dart';
import 'package:newsapp/models/news_response.dart';
import 'package:newsapp/models/source_response.dart';
class ApiManager {
  final Dio dio;
  ApiManager(this.dio);

  Future<SourceResponse> getSource() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${EndPoints.sourceApi}',
        queryParameters: {
          'apiKey': ApiConstants.apiKey,
        },
      );
      var responseData = response.data;
      SourceResponse sourceResponse = SourceResponse.fromJson(responseData);
      print(sourceResponse.status);
      print(response.data);
      return sourceResponse;

    } catch (e) {

      throw Exception('Failed to fetch sources');
    }
  }


  Future<NewsResponse> getNewsBySourceId(String sourceId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${EndPoints.newsApi}',
        queryParameters: {
          'apiKey': ApiConstants.apiKey,
          'sources': sourceId,
        },
      );

      var responseData = response.data;
      NewsResponse newsResponse = NewsResponse.fromJson(responseData);

      print(newsResponse.status);
      print(response.data);

      return newsResponse; 
    } catch (e) {
      throw Exception("Failed to fetch news");
    }
  }

}
