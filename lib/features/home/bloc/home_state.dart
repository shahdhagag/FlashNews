part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

class OnChangeTabState extends HomeState {}

class GetSourceLoadingState extends HomeState {}

class GetSourceSuccessState extends HomeState {}

class GetSourceErrorState extends HomeState {
  final String errorMsg;

  GetSourceErrorState(this.errorMsg);
}

class GetNewsLoadingState extends HomeState {}

class GetNewsSuccessState extends HomeState {}

class GetNewsErrorState extends HomeState {
  final String errorMsg;

  GetNewsErrorState(this.errorMsg);
}
