import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:newsApp/features/home/data/Repo/home_repo.dart';
import 'package:newsApp/models/news_response.dart';
import 'package:newsApp/models/source_response.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitialState());

  List<Sources> sourcesList = [];
  List<Articles> newsList = [];
  int selectedIndex = 0;

  /// Get Sources
  Future<void> getSources(String categoryId) async {
    emit(GetSourceLoadingState());

    try {
      SourceResponse sourceResponse = await homeRepo.getSources(categoryId);
      sourcesList = sourceResponse.sources ?? [];

      // final response = await ApiService.dio.get(EndPoints.sourceApi,queryParameters: {
      //   "category":categoryId
      // });
      // SourceResponse sourceResponse = SourceResponse.fromJson(response.data);
      //sourcesList = sourceResponse.sources ?? [];
      //  Load first tab news automatically

      if (sourcesList.isNotEmpty) {
        selectedIndex = 0;
        await getNewsData();
      }

      emit(GetSourceSuccessState());
    } catch (e) {
      emit(GetSourceErrorState(e.toString()));
    }
  }

  /// Change Tab
  void changeSelectedTab(int index) async {
    selectedIndex = index;
    emit(OnChangeTabState());

    await getNewsData();
  }

  /// Get News Data
  Future<void> getNewsData() async {
    emit(GetNewsLoadingState());

    try {
      NewsResponse newsResponse = await homeRepo.getNewsData(
        sourcesList[selectedIndex].id!,
      );
      // final response = await ApiService.dio.get(
      //   EndPoints.newsApi,
      //   queryParameters: {"sources": sourcesList[selectedIndex].id},

      //NewsResponse newsResponse = NewsResponse.fromJson(response.data);

      newsList = newsResponse.articles ?? [];

      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetNewsErrorState(e.toString()));
    }
  }

  /// search
  Future<void> searchNews(String query) async {
    if (query.isEmpty) return;
    emit(GetNewsLoadingState());

    try {
      NewsResponse newsResponse = await homeRepo.searchNews(query);

      // FILTER: Remove articles that are [Removed] or have no title
      newsList = (newsResponse.articles ?? []).where((article) {
        return article.title != null &&
            article.title != "[Removed]" &&
            article.urlToImage != null;
      }).toList();

      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetNewsErrorState("Search failed. Please try again."));
    }
  }
}
