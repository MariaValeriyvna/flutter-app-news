import 'package:app_news/pages/last_news_page/cubit/last_news_cubit.dart';
import 'package:app_news/pages/search.dart';
import 'package:app_news/widgets/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/article_model.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/custom_tag.dart';
import 'article.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LastNewsCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(index: 0),
        extendBodyBehindAppBar: true,
        body: const _LastNewsPage(),
      ),
    );
  }
}

class _LastNewsPage extends StatelessWidget {
  const _LastNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastNewsCubit, LastNewsState>(builder: (context, state) {
      if (state is LastNewsInitialState) {
        context.read<LastNewsCubit>().loadLastNews();
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is LastNewsErrorState) {
        return Center(
          child: Text(state.errorMessage),
        );
      }
      if (state is LastNewsLoadedState) {
        return RefreshIndicator(
          child: listBuilder(context, state),
          onRefresh: () => context.read<LastNewsCubit>().reloadLastNews(),
        );
      }
      return Container();
    });
  }

  Widget listBuilder(BuildContext context, LastNewsLoadedState state) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _NewsOfTheDay(article: state.lastNews[0]),
        _BreakingNews(articles: state.lastNews),
      ],
    );
  }
}

class _BreakingNews extends StatelessWidget {
  const _BreakingNews({
    required this.articles,
  });

  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SearchPage.routeName);
                    },
                    child: Text('More',
                        style: Theme.of(context).textTheme.bodyLarge)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 200,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ArticlePage.routeName,
                        arguments: articles[index],
                      );
                    },
                    child: Stack(children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageContainer(
                              width: MediaQuery.of(context).size.width * 0.5,
                              urlToImage: articles[index].urlToImage,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              articles[index].title,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold, height: 1.5),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy HH:mm').format(
                                  DateTime.parse(articles[index].publishedAt)),
                              style: Theme.of(context).textTheme.bodySmall!,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                'by ${articles[index].author}',
                                style: Theme.of(context).textTheme.bodySmall!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ]),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) =>
                            Positioned(
                                left: 10,
                                top: 10,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      articles[index].favorite =
                                          !articles[index].favorite;
                                    });
                                  },
                                  icon: Icon(
                                    articles[index].favorite
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: Colors
                                        .white, // цвет иконки можно изменить по желанию
                                  ),
                                  color: Colors.white,
                                )),
                      )
                    ]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _NewsOfTheDay extends StatelessWidget {
  const _NewsOfTheDay({
    super.key,
    required this.article,
  });

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      urlToImage: article.urlToImage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTag(
            backgroundColor: Colors.grey.withAlpha(150),
            children: [
              Text(
                'News of the Day',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            article.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  color: Colors.white,
                ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ArticlePage.routeName,
                      arguments: article,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Learn more',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
