import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_tutorial/bloc/login_bloc.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  static const routeName = '/test';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    return BlocConsumer<LoginBloc, LoginState>(
      //  Перестраивает дерево виджетов в ответ на изменения состояния.
      //Это значит, что каждый раз при создании нового состояния происходит перестройка виджетов.
      // В результате вы можете воспользоваться значением, которое передается в состояние, генерируемое в Bloc.
      // В данном примере мы передали текст из Bloc в UpdateTextState и применили его в UI. 
      //Это состояние порождается всякий раз при нажатии на кнопку “Tap me!!!”(“Нажми меня!!!”).
        builder: (context, state) {
          return _buildParentWidget(context, state);
        },
        //  Каждый раз, когда генерируется состояние, вызывается слушатель listener. 
        //Однако в отличие от builder он не возвращает виджет. Как правило, мы задействуем слушателя единожды,
        // поскольку он вызывается один раз при каждом изменении состояния. 
        //Например, при отображении сообщения внизу экрана, диалогового окна, всплывающей информационной панели или переходе к следующему экрану.
        listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('This is a snack bar!!!!'),
            ));
        },
        // Это необязательный параметр, который предоставляет предыдущее и текущее состояние и возвращает логическое значение. 
        //Если мы возвращаем true, он вызывает builder, в противном же случае этого не происходит. 
        //Если данный параметр отсутствует, builder вызывается при каждом изменении состояния.
        buildWhen: (previous, current) => _shouldBuildFor(current),
        // Аналогичен buildWhen, но отвечает за управление Listener. Если возвращается true, вызывается слушатель.
        listenWhen: (previous, current) => _shouldListenFor(current),

    );
  }

  bool _shouldListenFor(LoginState currentState) {
    return currentState is ShowSnackbarState;
  }

  bool _shouldBuildFor(LoginState currentState) {
    return currentState is LoginInitial || currentState is UpdateTextState;
  }

  Widget _buildParentWidget(BuildContext context, LoginState state) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTextWidget(state),
          const SizedBox(
            height: 16,
          ),
          TextButton(
            onPressed: () {
              context.read<LoginBloc>().add(LoginButtonTappedEvent());
            },
            child: const Text("Tap me!!!"),
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
              onPressed: () {
                context
                    .read<LoginBloc>()
                    .add(ShowSnackBarButtonTappedEvent());
              },
              child: const Text("Show Snackbar"))
        ],
      ),
    );
  }

  Widget _buildTextWidget(LoginState state) {
    if (state is UpdateTextState) {
      return Text(state.text);
    }
    else {
      return const Text("This will change on button tap");
    }
  }
}