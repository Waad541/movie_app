import 'package:flutter/material.dart';
import 'package:movie_app/main_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MainScreen.routeName:(context)=>MainScreen(),

      },
      initialRoute: MainScreen.routeName,
    );
  }
}

