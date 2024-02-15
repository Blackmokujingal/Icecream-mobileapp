import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTabChange;

  const MyBottomNavBar({Key? key, required this.currentIndex, required this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      height: 60,
      color: Colors.pink[200]!,
      buttonBackgroundColor: Colors.pink[300]!,
      index: currentIndex,
      onTap: onTabChange,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(Icons.shopping_bag_rounded, size: 30, color: Colors.white),
      ],
    );
  }
}