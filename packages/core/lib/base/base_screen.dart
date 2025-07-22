import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseScreen<ViewModel extends ChangeNotifier> extends StatelessWidget {
  const BaseScreen({super.key});
  String get screenTitle;
  Color get appbarColor;
  Color get bodyColor;

  ViewModel createViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (_) => createViewModel(),
      child: Scaffold(
        backgroundColor: appbarColor,
        appBar: _buildAppBar(),
        body: _buildBody(context)
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: appbarColor,
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
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Consumer<ViewModel>(
        builder: (_, vm, __) {
          if ((vm as dynamic).isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }
          return buildBody(context, vm);
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, ViewModel vm);
}