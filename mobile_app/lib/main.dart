import 'package:flutter/material.dart';
import 'package:mobile_app/utils/app_colors.dart';
import 'package:mobile_app/pages/firstpage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodLinq',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.crimson,
          primary: AppColors.crimson,
        ),
        scaffoldBackgroundColor: AppColors.background,
      ),
      debugShowCheckedModeBanner: false,
      home: const Firstpage(),
    );
  }
}

