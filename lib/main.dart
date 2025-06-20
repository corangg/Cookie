import 'package:flutter/material.dart';
import 'package:cookie/screen/oven_screen.dart';
import 'package:cookie/screen/collection_screen.dart';
import 'package:cookie/screen/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
    );
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
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Color(0xFFF0F0F0),
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/ic_oven.png',width: 32,height: 32,),
              activeIcon: Image.asset('assets/icons/ic_oven.png',width: 40,height: 40,),
              label: 'oven'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/ic_collection.png',width: 32,height: 32,),
              activeIcon: Image.asset('assets/icons/ic_collection.png',width: 40,height: 40,),
              label: 'collection'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,size: _selectedIndex == 2 ? 40 :32,color: Color(0xFFF5B82B),), label: 'Profile'),
        ],
      ),
    );
  }
}