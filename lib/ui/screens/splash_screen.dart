import 'package:contact_app/core/utils/colors.dart';
import 'package:contact_app/core/utils/images.dart';
import 'package:contact_app/core/utils/routes.dart' show AppRoutes;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Duration splashDuration = const Duration(seconds: 3);


class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Center(
            child: Image.asset(AppImages.logo),
          ),
          ElevatedButton(onPressed: (){
            Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
          }, child: Text('Go to Home Screen'))
        ],
      ),

    );
  }
}