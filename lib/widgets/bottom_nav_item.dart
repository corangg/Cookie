import 'package:core/values/app_color.dart';
import 'package:core/values/app_size.dart';
import 'package:flutter/material.dart';

class NavItemData {
  final String asset;
  final bool isProfile;

  const NavItemData(this.asset, {this.isProfile = false});
}

class BottomNavItem extends StatelessWidget {
  final String iconAssets;
  final bool isSelected;

  const BottomNavItem({
    super.key,
    required this.iconAssets,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.bottomNavigationBarIconBackground,
        border: Border.all(color: AppColor.bottomNavigationBarIcon, width: 2),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Image.asset(
        iconAssets,
        width: isSelected
            ? AppSize.bottomNavigationBarActiveIcon
            : AppSize.bottomNavigationBarIcon,
        height: isSelected
            ? AppSize.bottomNavigationBarActiveIcon
            : AppSize.bottomNavigationBarIcon,
      ),
    );
  }
}

class BottomNavProfileItem extends StatelessWidget {
  final String iconAssets;
  final bool isSelected;

  const BottomNavProfileItem({
    super.key,
    required this.iconAssets,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isSelected ? 12 : 14),
      decoration: BoxDecoration(
        color: AppColor.bottomNavigationBarIconBackground,
        border: Border.all(color: AppColor.bottomNavigationBarIcon, width: 2),
        borderRadius: BorderRadius.circular(
          AppSize.bottomNavigationBarIconRadius,
        ),
      ),
      child: Image.asset(
        iconAssets,
        color: AppColor.bottomNavigationBarIcon,
        width: isSelected
            ? AppSize.bottomNavigationBarActiveIcon - 8
            : AppSize.bottomNavigationBarIcon - 12,
        height: isSelected
            ? AppSize.bottomNavigationBarActiveIcon - 8
            : AppSize.bottomNavigationBarIcon - 12,
      ),
    );
  }
}