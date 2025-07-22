import 'package:cookie/di/injection.dart';
import 'package:cookie/notification/notification.dart';
import 'package:cookie/screen/collection_screen.dart';
import 'package:cookie/screen/oven_screen.dart';
import 'package:cookie/screen/more_screen.dart';
import 'package:cookie/widgets/bottom_nav_item.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/widgets/custom_bottom_nav_bar.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const MainScreen(),
      navigatorObservers: [routeObserver],
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
    const OvenScreen(),
    const CollectionScreen(),
    const MoreScreen(),
  ];

  final List<NavItemData> _navItemDataList = const [
    NavItemData(AppAssets.icOven),
    NavItemData(AppAssets.icCollection),
    NavItemData(AppAssets.icMenu),
  ];

  @override
  Widget build(BuildContext context) {
    final navItems = List.generate(_navItemDataList.length, (index) {
      final icon = _navItemDataList[index];
      final isSelected = _selectedIndex == index;

      return icon.isProfile
          ? BottomNavProfileItem(iconAssets: icon.asset, isSelected: isSelected)
          : BottomNavItem(iconAssets: icon.asset, isSelected: isSelected);
    });
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: navItems,
      ),
    );
  }
}
