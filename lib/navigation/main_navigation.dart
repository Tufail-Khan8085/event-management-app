import 'package:flutter/material.dart';

// Correct Nav Import
import 'package:event/core/widgets/custom_bottom_nav.dart';

// All Screens Imports
import 'package:event/setting/settings_screen.dart';
import 'package:event/user/screen/community/community_screen.dart';
import 'package:event/user/screen/favourite/favorite_screen.dart';
import 'package:event/user/screen/features/feature_screen.dart';
import 'package:event/user/screen/home/home_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const FeatureScreen(),
    const CommunityScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}