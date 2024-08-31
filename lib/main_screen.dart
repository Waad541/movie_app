import 'package:flutter/material.dart';
import 'package:movie_app/tabs/browser_screen.dart';
import 'package:movie_app/tabs/home_screen.dart';
import 'package:movie_app/tabs/search_screen.dart';
import 'package:movie_app/tabs/watch_list_screen.dart';

class MainScreen extends StatefulWidget {
  static const String routeName='main';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff1A1A1A),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },
        selectedItemColor: Colors.amber,
        unselectedItemColor: Color(0xffC6C6C6),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.open_in_browser_outlined), label: 'Browser'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'Watch List')
        ],
      ),
    );
  }

  List<Widget> tabs = [
    HomeScreen(),
    SearchScreen(),
    BrowserScreen(),
    WatchListScreen()
  ];
}
