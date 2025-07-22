import 'package:cookie/di/injection.dart';
import 'package:cookie/values/assets.dart';
import 'package:cookie/viewmodel/more_screen_view_model.dart';
import 'package:core/base/base_screen.dart';
import 'package:core/values/app_color.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';

class MoreScreen extends BaseScreen<MoreScreenViewModel> {
  const MoreScreen({super.key});

  @override
  Color get appbarColor => AppColor.mainBackground;

  @override
  Color get bodyColor => AppColor.mainBackground;

  @override
  String get screenTitle => 'Menu';

  @override
  MoreScreenViewModel createViewModel() => sl<MoreScreenViewModel>();

  @override
  Widget buildBody(BuildContext context, MoreScreenViewModel viewModel) {
    return MoreContent(viewModel: viewModel);
  }
}

class MoreContent extends StatefulWidget {
  final MoreScreenViewModel viewModel;
  const MoreContent({super.key, required this.viewModel});

  @override
  State<MoreContent> createState() => _MoreContentState();
}

class _MoreContentState extends State<MoreContent> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return _profileListView(CookieAssets.moreItemList, screenWidth, screenHeight);
  }

  Widget _profileListView(List<MoreItemData> items, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight*0.05),
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _itemBuilder(item,screenHeight*0.05);
          }),
    );
  }

  Widget _itemBuilder(MoreItemData item, double itemHeight) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              print('더보기 아이템(${item.item}) 클릭됨!');
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: itemHeight * 0.3,),
              child: SizedBox(
                height: itemHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: itemHeight * 0.9, height: itemHeight * 0.9, child: Image.asset(item.iconAsset),),
                    SizedBox(width: itemHeight * 0.3),
                    Expanded(child: Text(item.item, style: const TextStyle(fontSize: 16, color: AppColor.mainTextColor, fontWeight: FontWeight.bold,),),),
                  ],
                ),
              ),
            )
        )
    );
  }
}