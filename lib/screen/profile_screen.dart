import 'package:cookie/di/injection.dart';
import 'package:cookie/viewmodel/profile_screen_view_model.dart';
import 'package:core/base/base_screen.dart';
import 'package:core/values/app_color.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends BaseScreen<ProfileScreenViewModel> {
  const ProfileScreen({super.key});

  @override
  Color get appbarColor => AppColor.mainBackground;

  @override
  Color get bodyColor => AppColor.mainBackground;

  @override
  String get screenTitle => 'Profile';

  @override
  ProfileScreenViewModel createViewModel() => sl<ProfileScreenViewModel>();

  @override
  Widget buildBody(BuildContext context, ProfileScreenViewModel vm) {
    return Stack();
  }
}