import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/article_model.dart';
import '../../../services/api_service.dart';

part 'last_news_state.dart';

class LastNewsCubit extends Cubit<LastNewsState> {
  LastNewsCubit() : super(LastNewsInitialState());

  Future<void> loadLastNews() async {
    try {
      emit(LastNewsLoadedState(lastNews: await ApiService().getArticles()));
    } catch (e) {
      emit(const LastNewsErrorState('Ooops!'));
    }
  }

  Future<void> reloadLastNews() async {
    emit(LastNewsInitialState());
  }
}
