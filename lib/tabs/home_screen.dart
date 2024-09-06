import 'package:flutter/material.dart';
import 'package:movie_app/home/popular_section.dart';
import 'package:movie_app/home/recommend_section.dart';
import 'package:movie_app/home/releases_section.dart';

import '../watchlist/watch_list_model.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WatchListModel model = WatchListModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PopularSection(),
            SizedBox(height: 10),
            ReleasesSection(),
            SizedBox(height: 10),
            RecommendSection(),
          ],
        ),
      ),
    );
  }
}
