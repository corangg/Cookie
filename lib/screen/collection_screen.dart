import 'package:cookie/di/injection.dart';
import 'package:cookie/viewmodel/collection_view_model.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CollectionViewModel>(
      create: (_) => sl<CollectionViewModel>(),
      child: const _CollectionBody(),
    );
  }
}

class _CollectionBody extends StatefulWidget {
  const _CollectionBody({super.key});

  @override
  State<_CollectionBody> createState() => _CollectionBodyState();
}

class _CollectionBodyState extends State<_CollectionBody> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainBackground,
      appBar: _buildAppBar(),
      body: SafeArea(child: Consumer<CollectionViewModel>(builder: (_, vm, _) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildBody();
        }
      })),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.mainBackground,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Collection',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,       // 가로: 오른쪽, 세로: 중앙
          child: Image.asset(
            AppAssets.imgCollectionCheeringHalf,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}