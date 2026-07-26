import 'package:event/screen/splash/splash_screen.dart';
import 'package:event/setting/settings_screen.dart';
import 'package:event/user/screen/community/community_screen.dart';
import 'package:event/user/screen/favourite/favorite_screen.dart';
import 'package:event/user/screen/features/feature_screen.dart';
import 'package:flutter/material.dart';
import 'package:event/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}