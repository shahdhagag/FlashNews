import 'package:newsApp/models/news_response.dart';
import 'package:newsApp/models/source_response.dart';



abstract class HomeRemoteRepo{
  Future <SourceResponse> getSources(String categoryId) ;
  Future <NewsResponse> getNewsData(String sourceId);
  Future <NewsResponse> searchNews(String query);

}