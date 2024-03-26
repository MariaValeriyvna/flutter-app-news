part of 'last_news_cubit.dart';
/*
* Один базовый абстрактный класс нужен для того, чтобы
* на его основе создавать дочерние классы
* в тех файлах, где он используется.
* */
sealed class LastNewsState extends Equatable {
  const LastNewsState();

  @override
  List<Object> get props => [];
}

// класс Начального состояния
final class LastNewsInitialState extends LastNewsState {}

// класс Состояния загрузки
class LastNewsLoadedState extends LastNewsState {
  final List<ArticleModel> lastNews;
  const LastNewsLoadedState({required this.lastNews});
}

// класс Состояния ошибки
class LastNewsErrorState extends LastNewsState {
  final String errorMessage;
  const LastNewsErrorState(this.errorMessage);
}