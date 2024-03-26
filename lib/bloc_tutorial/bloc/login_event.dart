part of 'login_bloc.dart';
// Это простой абстрактный класс 
// который можно расширить для других событий 
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}


class LoginButtonTappedEvent extends LoginEvent {}
class ShowSnackBarButtonTappedEvent extends LoginEvent {}
