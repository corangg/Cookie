import 'package:core/util/util.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';

class CollectionWidget extends StatefulWidget {
  final List<String> items;

  const CollectionWidget({super.key, required this.items});

  @override
  State<CollectionWidget> createState() => _CollectionBackgroundWidget();
}

class _CollectionBackgroundWidget extends State<CollectionWidget> {
  final ScrollController _controller = ScrollController();
  double _scrollOffset = 0.0;

  final test = CollectionData(type: CookieType.fromCode(1), no: 14, date: createTodayDate());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final topPaddingValue = screenHeight * 0.03;
    final maxWidth = screenWidth * 0.9;
    const crossAxisCount = 2;
    final cellWidth = maxWidth / crossAxisCount;
    final cellHeight = cellWidth * 1.3;
    final rowCount = (widget.items.length / crossAxisCount).ceil();
    final scrollHeight = cellHeight * rowCount;
    final backgroundAsset = _backgroundAsset(_getScrollValue(scrollHeight, screenHeight - topPaddingValue));

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        setState(() {_scrollOffset = scrollInfo.metrics.pixels;});
        return false;
      },
      child: SingleChildScrollView(
        controller: _controller,
        child: SizedBox(
          width: maxWidth,
          height: scrollHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _setBackgroundImage(backgroundAsset, maxWidth, scrollHeight),

              Positioned(top: topPaddingValue,
                  left: screenWidth * 0.10,
                  right: screenWidth * 0.10,
                  bottom: 0,
                  child: _collectionGridView(crossAxisCount))
            ],
          ),
        ),
      ),
    );
  }

  Widget _collectionGridView(int crossAxisCount) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1 / 1.3,
      ),
      itemCount: widget.items.length,
      itemBuilder: (_, idx) =>
          Padding(
            padding: const EdgeInsets.all(12),
            child: _itemCollectionData(test),
          ),
    );
  }

  Widget _itemCollectionData(CollectionData data) {
    final openCookieImg = AppAssets.imgTypeOpenCookie(data.type.code);
    return AspectRatio(
        aspectRatio: 1 / 1.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 8, child: Image.asset(
                openCookieImg
            )),

            Expanded(flex: 2, child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppAssets.imgCollectionNo, fit: BoxFit.contain,),
                Text('No.${data.no}',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColor.mainButtonBorder,
                      fontWeight: FontWeight.w800
                  ),)
              ],)
            )
          ],
        )
    );
  }

  Widget buildCroppedFitWidthImage({
    required String assetPath,
    required double width,
    required double height,
    required Alignment alignment,
    //Alignment alignment = Alignment.topCenter,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRect(
        child: Align(
          alignment: alignment,
          child: Image.asset(
            assetPath,
            width: width,
            fit: BoxFit.fitWidth,
            gaplessPlayback: true,
          ),
        ),
      ),
    );
  }

  Widget _setBackgroundImage(String backgroundAsset, double backgroundWidth, double backgroundHeight) {
    return switch(backgroundAsset){
      AppAssets.imgCollectionBackgroundTop => buildCroppedFitWidthImage(assetPath: backgroundAsset,
          width: backgroundWidth,
          height: backgroundHeight,
          alignment: Alignment.topCenter),
      AppAssets.imgCollectionBackgroundBottom => buildCroppedFitWidthImage(assetPath: backgroundAsset,
          width: backgroundWidth,
          height: backgroundHeight,
          alignment: Alignment.bottomCenter),
      _ => Image.asset(
        backgroundAsset,
        width: backgroundWidth,
        height: backgroundHeight,
        fit: BoxFit.fill,
        gaplessPlayback: true,
      )
    };
  }

  String _backgroundAsset(double scrollValue) {
    return scrollValue < 0.1
        ? AppAssets.imgCollectionBackgroundTop
        : scrollValue < 0.9
        ? AppAssets.imgCollectionBackgroundMid
        : AppAssets.imgCollectionBackgroundBottom;
  }

  double _getScrollValue(double scrollHeight, double viewHeight) {
    final maxScroll = _controller.hasClients ? _controller.position.maxScrollExtent : (scrollHeight - (viewHeight)).clamp(0.0, 1.0);
    final offset = _scrollOffset.clamp(0.0, maxScroll);
    return maxScroll > 0 ? (offset / maxScroll).clamp(0.0, 1.0) : 0.0;
  }
}
