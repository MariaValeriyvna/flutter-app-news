import 'package:app_news/pages/search.dart';
import 'package:app_news/pages/home.dart';
import 'package:app_news/pages/test.dart';
import 'package:flutter/material.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(100),
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(left: 50),
            child:  IconButton(
            onPressed: () {
              Navigator.pushNamed(context, HomePage.routeName);
            },
            icon: const Icon(Icons.home),
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
            ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(right: 50),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, TestPage.routeName);
              },
              icon: const Icon(Icons.person),
            ),
          ),
          label: 'Profile',
        )
      ]
    );
  }
}

