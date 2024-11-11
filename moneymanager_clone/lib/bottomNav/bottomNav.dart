// ignore_for_file: prefer_const_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import '../views/home_page.dart';
import '../views/status_page.dart';
import '../views/budget_page.dart';

class MyBottomNavBar extends StatefulWidget {
  MyBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  List<Widget> pages = [
    HomePage(),
    BudgetPage(),
    StatusPage(),
  ];

  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.white,
        onDestinationSelected: (int index) {
          ind = index;
          setState(() {});
        },
        selectedIndex: ind,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: ImageIcon(
                AssetImage("assets/navigation_menu/ic_menu_home_selected.png")),
            icon: ImageIcon(
                AssetImage("assets/navigation_menu/ic_menu_home.png")),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(
                "assets/navigation_menu/ic_menu_vision_selected.png")),
            icon: ImageIcon(
                AssetImage("assets/navigation_menu/ic_menu_vision.png")),
            label: "Budget",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(
                "assets/navigation_menu/ic_menu_profile_selected.png")),
            icon: ImageIcon(
                AssetImage("assets/navigation_menu/ic_menu_profile.png")),
            label: "Status",
          ),
        ],
      ),
      body: IndexedStack(
        index: ind,
        children: pages,
      ),
    );
  }
}
