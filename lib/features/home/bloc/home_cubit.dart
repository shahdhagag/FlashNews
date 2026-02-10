import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newsapp/api/api_service.dart';
import 'package:newsapp/api/endpoints.dart';
import 'package:newsapp/models/news_response.dart';
import 'package:newsapp/models/source_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<Sources> sourcesList = [];
  List<Articles> newsList = [];
  int selectedIndex = 0;

  /// Get Sources
  Future<void> getSources(String categoryId) async {
    emit(GetSourceLoadingState());

    try {
      final response = await ApiService.dio.get(EndPoints.sourceApi,queryParameters: {
        "category":categoryId
      });

      SourceResponse sourceResponse = SourceResponse.fromJson(response.data);

      sourcesList = sourceResponse.sources ?? [];

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
      final response = await ApiService.dio.get(
        EndPoints.newsApi,
        queryParameters: {"sources": sourcesList[selectedIndex].id},
      );

      NewsResponse newsResponse = NewsResponse.fromJson(response.data);

      newsList = newsResponse.articles ?? [];

      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetNewsErrorState(e.toString()));
    }
  }
}
