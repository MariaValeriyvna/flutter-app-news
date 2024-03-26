part of 'login_bloc.dart';
/*
* Один базовый абстрактный класс нужен для того, чтобы
* на его основе создавать дочерние классы
* в тех файлах, где он используется.
* */
sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}


class UpdateTextState extends LoginState {
  final String text;
  const UpdateTextState({required this.text});
}

class ShowSnackbarState extends LoginState {}
