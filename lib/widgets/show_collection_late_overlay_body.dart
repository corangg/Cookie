import 'package:cookie/viewmodel/more_screen_view_model.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:core/values/app_string.dart';
import 'package:core/widgets/custom_img_button.dart';
import 'package:flutter/material.dart';

class ShowCollectionLateOverlayBody extends StatefulWidget {
  final double overlayWidth;
  final double overlayHeight;
  final MoreScreenViewModel viewModel;

  const ShowCollectionLateOverlayBody({
    super.key,
    required this.overlayWidth,
    required this.overlayHeight,
    required this.viewModel
  });

  @override
  State<ShowCollectionLateOverlayBody> createState() => _ShowCollectionLateOverlayBody();
}

class _ShowCollectionLateOverlayBody extends State<ShowCollectionLateOverlayBody> {
  late Future<List<int>> _lateListFuture;

  @override
  void initState() {
    super.initState();
    final items = AppAssets.cookieTypeAssetsList;
    _lateListFuture = widget.viewModel.getCollectionLate(items.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
        future: _lateListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          }

          return _buildBody(snapshot.data!);
        }
    );
  }

  Widget _buildBody(List<int> lateList) {
    final items = AppAssets.cookieTypeAssetsList;
    return Column(
      children: [
        SizedBox(height: widget.overlayHeight * 0.01,),
        Align(
          alignment: Alignment.center,
          child: Text('수집률', style: TextStyle(color: AppColor.mainTextColor, fontSize: 18, fontWeight: FontWeight.bold,),),
        ),
        SizedBox(
          width: widget.overlayWidth,
          height: widget.overlayHeight * 0.7,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final itemWidth = widget.overlayWidth * 0.2;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      _cookieIcon(itemWidth, item),
                      SizedBox(height: widget.overlayWidth * 0.01,),
                      Expanded(child: _lateBar(index, itemWidth * 0.6, lateList[index]))
                    ],
                  ),
                );
              }
          ),
        ),
      ],
    );
  }

  Widget _cookieIcon(double itemWidth, String itemAsset){
    return Container(
        width: itemWidth,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.mainBackground,
          border: Border.all(
              color: AppColor.bottomNavigationBarBorder, width: 3),
        ),
        alignment: Alignment.center,
        child: CustomImageButton(
          imgAssets: itemAsset, width: itemWidth * 0.5, height: itemWidth * 0.5,
        )
    );
  }

  Widget _lateBar(int index, double itemHeight, int late) {
    final itemSize = AppStrings.getCookieMessageList(index + 1).length;
    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = constraints.maxWidth;
        final double lateValue = late / itemSize;
        return Stack(
          children: [
            Container(
              width: barWidth * lateValue,
              height: itemHeight,
              decoration: BoxDecoration(
                color: AppColor.cookieTypeMainColor(index + 1),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Positioned(
              right: barWidth * 0.05,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.center,
                child: Text('$late/$itemSize', style: TextStyle(
                  color: AppColor.mainTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,),),
              ),
            ),
          ],
        );
      },
    );
  }
}