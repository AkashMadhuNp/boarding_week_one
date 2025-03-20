import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/feeds/feed.dart';
import 'package:bw_project/screens/profile/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    FeedScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20),
          child: CurvedNavigationBar(
            index: _selectedIndex,
            height: 60.0,
            color: AppColors.white, // Solid color for icon background
            buttonBackgroundColor: AppColors.white, // Solid color for active item
            backgroundColor: AppColors.black, // Transparent curved area
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            items: const [
              Icon(Icons.feed, size: 30),
              Icon(Icons.person, size: 30),
            ],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}