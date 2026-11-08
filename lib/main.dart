import 'package:contact_app/core/utils/routes.dart';
import 'package:contact_app/ui/screens/home_screen.dart';
import 'package:contact_app/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      routes: {
        AppRoutes.splashScreen: (context) =>  SplashScreen(),
        AppRoutes.homeScreen: (context) =>  HomeScreen(),
      },
      
    );
  }
}
