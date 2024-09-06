import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Theme/my_theme.dart';
import 'package:movie_app/browser_details.dart';
import 'package:movie_app/home/home_screen_details.dart';
import 'package:movie_app/main_screen.dart';
import 'package:movie_app/splash_screen.dart';
import 'package:movie_app/tabs/watch_list_screen.dart';


import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.theme,
      routes: {
        MainScreen.routeName:(context)=>MainScreen(),
        SplashScreen.routeName:(context)=>SplashScreen(),
        BrowserDetails.routeName:(context)=>BrowserDetails(),
        HomeScreenDetails.routeName:(context)=>HomeScreenDetails(),
        WatchListScreen.routeName:(context)=>WatchListScreen()

      },
      initialRoute: SplashScreen.routeName,
    );
  }
}

