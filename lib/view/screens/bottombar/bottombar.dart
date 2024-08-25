// ignore_for_file: prefer_const_constructors

import 'package:beekeep/view/screens/scan/scan_main_view.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/common_image_view_widget.dart';
import '../Todo/todo.dart';
import '../home/home.dart';
import '../home/map.dart';
import '../profile/profile_main_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens()[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(h(context, 30))),
        child: BottomNavigationBar(
          backgroundColor: kSecondaryColor,
          selectedLabelStyle: TextStyle(color: kTertiaryColor, fontSize: 0),
          unselectedLabelStyle: TextStyle(color: kGreyColor, fontSize: 0),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: 'Chat',
              icon: CommonImageView(
                fit: BoxFit.contain,
                imagePath: Assets.imagesBottom1,
                height: 26,
                width: 26,
              ),
              activeIcon: CommonImageView(
                fit: BoxFit.contain,
                imagePath: Assets.imagesActive1,
                height: 29,
                width: 26,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Maps',
              icon: CommonImageView(
                fit: BoxFit.contain,
                imagePath: Assets.imagesBottom2,
                height: 26,
                width: 26,
              ),
              activeIcon: CommonImageView(
                fit: BoxFit.contain,
                imagePath: Assets.imagesBottom2,
                height: 26,
                width: 26,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Scan',
              icon: CommonImageView(
                fit: BoxFit.contain,
                imagePath: Assets.imagesScanbottom,
                height: 44,
                width: 44,
              ),
              activeIcon: CommonImageView(
                fit: BoxFit.contain,
                imagePath: Assets.imagesScanbottom,
                height: 44,
                width: 44,
              ),
            ),
            BottomNavigationBarItem(
              label: 'ToDo',
              icon: CommonImageView(
                imagePath: Assets.imagesBottom3,
                fit: BoxFit.contain,
                height: 26,
                width: 26,
              ),
              activeIcon: CommonImageView(
                imagePath: Assets.imagesActive3,
                fit: BoxFit.contain,
                height: 29,
                width: 26,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: CommonImageView(
                imagePath: Assets.imagesBottom4,
                fit: BoxFit.contain,
                height: 26,
                width: 26,
              ),
              activeIcon: CommonImageView(
                imagePath: Assets.imagesActive4,
                fit: BoxFit.contain,
                height: 29,
                width: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const Home(),
      Maplocation(),
      const ScanMainView(),
      const Todo(),
      ProfileMainView(),
    ];
  }
}
