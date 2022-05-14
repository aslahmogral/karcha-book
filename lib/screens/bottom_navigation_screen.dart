import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/add_category/Category_main_screen.dart';
// import 'package:money_manager_app/screens/add_category_screen/Category_main_screen.dart';
// import 'package:money_manager_app/screens/add_category_screen/chart_screen/chart_main_screen.dart';
// import 'package:money_manager_app/screens/chart_screen/chart_main_screen.dart';
import 'package:money_manager_app/screens/home_screen.dart';

import 'package:money_manager_app/screens/setting_screen.dart';

import 'chart_screen/chart_main_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class  _BottomNavigationState  extends State<BottomNavigation> {
  int currentIndex = 0;
  final screens = [
    Center(
      child: Text('Bismillah'),
    ),
    Center(
      child: Text('Alhamdulillah'),
    ),
    Center(
      child: Text('Allahu akbar'),
    ),
    Center(
      child: Text('la ilaha illahallah'),
    ),
  ];

  // final screens2 = [screenOne(), screetwo(), screenThree(), screenFour()];

  final screensOfProject = [
    HomeScreen(),
    ChartScreen(),
    CategoryScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensOfProject[currentIndex],
     
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'chart',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'category',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }
}
