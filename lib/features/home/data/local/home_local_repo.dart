import 'package:newsApp/models/news_response.dart';
import 'package:newsApp/models/source_response.dart';



abstract class HomeLocalRepo{
  Future <SourceResponse> getSources(String categoryId) ;
  Future <NewsResponse> getNewsData(String sourceId);
  Future <NewsResponse> searchNews(String query);
  //save sources
  Future<void> saveSources(List<Sources> sources);
  //save articles
  Future<void> saveArticles(List<Articles> articles);
}

