import 'package:cookie/di/injection.dart';
import 'package:cookie/viewmodel/profile_screen_view_model.dart';
import 'package:core/values/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileScreenViewModel>(
      create: (_) => sl<ProfileScreenViewModel>(),
      child: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatefulWidget {
  const _ProfileBody({super.key});

  @override
  State<_ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<_ProfileBody>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainBackground,
      appBar: _buildAppBar(),
        body: SafeArea(
            child: Consumer<ProfileScreenViewModel>(builder: (_, vm, _) {
              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _buildBody(vm);
              }
            }))
    );
    throw UnimplementedError();
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.mainBackground,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Profile',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
  Widget _buildBody(ProfileScreenViewModel vm) {
    return Stack();
  }
}