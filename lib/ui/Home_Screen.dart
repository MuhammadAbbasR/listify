import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../constants/Colors.dart';
import 'List_Screen.dart';
import 'Task_Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    ListPage(),
    AddPage(),
  ];

  void setScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BackgroundColor,
      body: screens[_selectedIndex], // Show selected screen
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.deepPurple,
        barItems: [
          BarItem(title: "Home", icon: Icons.home),
          BarItem(title: "Add", icon: Icons.add_box_rounded),
        ],
        selectedIndex: _selectedIndex,
        onButtonPressed: setScreen,
        activeColor: Colors.white,
        inactiveColor: AppColors.inactivecolor,
        iconSize: 30,
      ),
    );
  }
}
