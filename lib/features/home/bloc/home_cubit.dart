import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:newsApp/features/home/data/local/home_local_repo.dart';
import 'package:newsApp/features/home/data/remote/home__remote_repo.dart';
import 'package:newsApp/models/news_response.dart';
import 'package:newsApp/models/source_response.dart';
import '../../../core/network/internet_checker.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRemoteRepo homeRemoteRepo;
  final HomeLocalRepo homeLocalRepo;
  final InternetConnectivity internetConnectivity;

  HomeCubit(this.homeRemoteRepo, this.homeLocalRepo, this.internetConnectivity)
    : super(HomeInitialState());

  List<Sources> sourcesList = [];
  List<Articles> newsList = [];
  int selectedIndex = 0;
  Timer? _debounce;

  Future<void> getSources(String categoryId) async {
    emit(GetSourceLoadingState());
    try {
      final response = await _fetchSourcesWithCache(categoryId);
      sourcesList = response.sources ?? [];

      if (sourcesList.isNotEmpty) {
        selectedIndex = 0;
        await getNewsData();
      }
      emit(GetSourceSuccessState());
    } catch (e) {
      emit(GetSourceErrorState(e.toString()));
    }
  }

  Future<void> getNewsData() async {
    if (sourcesList.isEmpty) return;
    emit(GetNewsLoadingState());
    try {
      final sourceId = sourcesList[selectedIndex].id!;
      final response = await _fetchNewsWithCache(sourceId);

      newsList = (response.articles ?? [])
          .where((a) => a.title != null && a.title != "[Removed]")
          .toList();

      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetNewsErrorState(e.toString()));
    }
  }

  Future<SourceResponse> _fetchSourcesWithCache(String categoryId) async {
    if (await internetConnectivity.isConnected) {
      final remoteData = await homeRemoteRepo.getSources(categoryId);
      if (remoteData.sources != null) {
        await homeLocalRepo.saveSources(remoteData.sources!);
      }
      return remoteData;
    }
    return await homeLocalRepo.getSources(categoryId);
  }

  Future<NewsResponse> _fetchNewsWithCache(String sourceId) async {
    if (await internetConnectivity.isConnected) {
      try {
        final remoteData = await homeRemoteRepo.getNewsData(sourceId);
        if (remoteData.articles != null) {
          await homeLocalRepo.saveArticles(remoteData.articles!);
        }
        return remoteData;
      } catch (e) {
        // lw 7sl m4kla f remote get it from local
        return await homeLocalRepo.getNewsData(sourceId);
      }
    }
    return await homeLocalRepo.getNewsData(sourceId);
  }

  void changeSelectedTab(int index) {
    selectedIndex = index;
    emit(OnChangeTabState());
    getNewsData();
  }

  void searchNewsDebounced(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () => searchNews(query),
    );
  }

  /// search
  Future<void> searchNews(String query) async {
    if (query.isEmpty) return;

    emit(GetNewsLoadingState());

    try {
      NewsResponse newsResponse;

      if (await internetConnectivity.isConnected) {
        /// Online search
        newsResponse = await homeRemoteRepo.searchNews(query);
      } else {
        /// Offline search from Hive box
        newsResponse = await homeLocalRepo.searchNews(query);
      }

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

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
