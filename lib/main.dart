import 'package:cookie/screen/collection_screen.dart';
import 'package:cookie/screen/oven_screen.dart';
import 'package:cookie/screen/profile_screen.dart';
import 'package:core/app_assets.dart';
import 'package:core/app_string.dart';
import 'package:core/app_size.dart';
import 'package:core/app_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CollectionScreen(),
    const OvenScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColor.bottomNavigationBarBackground,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.icOven,
              width: AppSize.bottomNavigationBarIconSize,
              height: AppSize.bottomNavigationBarIconSize,
            ),
            activeIcon: Image.asset(
              AppAssets.icOven,
              width: AppSize.bottomNavigationBarActiveIconSize,
              height: AppSize.bottomNavigationBarActiveIconSize,),
            label: AppStrings.labelBottomNavigationBarOven),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.icCollection,
              width: AppSize.bottomNavigationBarIconSize,
              height: AppSize.bottomNavigationBarIconSize,),
            activeIcon: Image.asset(
              AppAssets.icCollection,
              width: AppSize.bottomNavigationBarActiveIconSize,
              height: AppSize.bottomNavigationBarActiveIconSize,),
            label: AppStrings.labelBottomNavigationBarCollection,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: _selectedIndex == 2 ? AppSize.bottomNavigationBarActiveIconSize : AppSize.bottomNavigationBarIconSize,
              color: AppColor.bottomNavigationBarIcon,
            ),
            label: AppStrings.labelBottomNavigationBarProfile,
          ),
        ],
      ),
    );
  }
}
