import 'package:app_news/bloc_tutorial/bloc/login_bloc.dart';
import 'package:app_news/pages/article.dart';
import 'package:app_news/pages/home.dart';
import 'package:app_news/pages/search.dart';
import 'package:app_news/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//  https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=56f7801630c14a25b16d00e8e6d09119

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // виджет BlocProvider.
    //Благодаря ему Bloc становится доступным для всего дерева виджетов, которое передается в параметре child
    return BlocProvider(
      create: (BuildContext context) {
        return LoginBloc();
      },
      child: MaterialApp(
          title: 'Flutter News',
          theme: ThemeData(primarySwatch: Colors.grey),
          initialRoute: '/',
          routes: {
              // const - чтобы объект не пересоздавался в процессе перерисовке(не будет удалятся и создаваться заново)
            HomePage.routeName: (context) => const HomePage(),
            SearchPage.routeName: (context) => const SearchPage(),
            ArticlePage.routeName: (context) => const ArticlePage(),
            TestPage.routeName: (context) => const TestPage(),
          }),
    );
  }
}
