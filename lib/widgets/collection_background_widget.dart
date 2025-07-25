import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:core/values/app_string.dart';
import 'package:core/widgets/top_right_close_button.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';

class CollectionWidget extends StatefulWidget {
  final List<CollectionData> items;
  final double screenWidth;
  final double screenHeight;
  final bool isCollected;
  final ValueChanged<CollectionData> onTap;

  const CollectionWidget({
    super.key,
    required this.items,
    required this.screenWidth,
    required this.screenHeight,
    required this.isCollected,
    required this.onTap
  });

  @override
  State<CollectionWidget> createState() => _CollectionBackgroundWidget();
}

class _CollectionBackgroundWidget extends State<CollectionWidget> {
  List<Widget> _backgroundWidgets =[];
  List<CollectionData> collectionList = [];

  late final double screenWidth;
  late final double screenHeight;
  late final double itemWidth;
  late final double itemHeight;
  late final int crossAxisCount;
  late final double bottomPaddingValue;

  double _scrollOffset = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setScreenValue();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    collectionList = _modifyList();
    final rowCount = (collectionList.length / crossAxisCount).ceil();
    if(rowCount == 4){
      _set4ColumnBackgroundWidgets(screenWidth);
    }else{
      _setBackgroundWidgets(screenWidth);
    }
    return _scrollBody();
  }

  Widget _scrollBody(){
    final topPaddingValue = screenHeight * 0.04;
    final maxWidth = screenWidth * 0.9;

    final scrollHeight = _calculateScrollHeight();
    final viewHeight = screenHeight - screenHeight* 0.2;
    final canScroll    = scrollHeight > viewHeight;

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        setState(() {_scrollOffset = scrollInfo.metrics.pixels;});
        return false;
      },
      child: canScroll?
      SingleChildScrollView(
        primary: true,
        child: SizedBox(
          width: maxWidth,
          height: scrollHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              IndexedStack(
                  index: _getScrollSection(scrollHeight, viewHeight),//_getScrollIndex(scrollValue),
                  children: _backgroundWidgets),
              Positioned(
                  top: topPaddingValue,
                  left: screenWidth * 0.1,
                  right: screenWidth * 0.1,
                  bottom: 0,
                  child: _collectionGridView()
              )
            ],
          ),
        ),
      ): Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: 0,
              child: Image.asset(
                  AppAssets.imgCollectionBackground, width: maxWidth,
                  height: viewHeight,
                  fit: BoxFit.fill,
                  gaplessPlayback: true)),
          Positioned(
              top: topPaddingValue,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              //bottom: heightPaddingValue,
              child: _collectionGridView())
        ],
      ),
    );
  }

  Widget _collectionGridView() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: itemHeight,
        mainAxisSpacing: 8,
        maxCrossAxisExtent: itemWidth,
        crossAxisSpacing: 8,
      ),
        itemCount: collectionList.length,
        itemBuilder: (_, index) {
          final data = collectionList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _itemCollectionData(data, onTap: () {
              if (data.type.code == 6) {
                ScaffoldMessenger.of(context).showSnackBar(_showUnCollectedCookieMessage());
              } else {
                widget.onTap(data);
              }
            }),
          );
        }
    );
  }

  Widget _itemCollectionData(CollectionData data,{required VoidCallback onTap}) {
    final openCookieImg = AppAssets.imgTypeOpenCookie(data.type.code);
    return InkWell(
      onTap: onTap,
      child: AspectRatio(
          aspectRatio: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 8, child: Image.asset(openCookieImg)),
              Expanded(flex: 2, child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.collectionCookieButton,
                          border: Border.all(color: AppColor.bottomNavigationBarBorder, width: 2),
                          borderRadius: BorderRadius.circular(6)
                      ),
                    ),
                    Text('No.${data.no}',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColor.mainButtonBorder,
                            fontWeight: FontWeight.w800
                        )
                    )
                  ])
              )
            ],
          )
      ),
    );
  }

  Widget buildCroppedFitWidthImage({
    required String assetPath,
    required double width,
    required double height,
    required Alignment alignment,
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

  Widget buildBackgroundImage({
    required String assetPath,
    required double width,
    required Alignment alignment,
  }) {
    return Image.asset(
      assetPath,
      width: width,
      fit: BoxFit.fitWidth,
      alignment: alignment,
      gaplessPlayback: true,
    );
  }

  int _getScrollSection(double scrollHeight, double viewHeight) {
    final controller = PrimaryScrollController.of(context);
    final maxScroll = controller.hasClients ? controller.position.maxScrollExtent : (scrollHeight - viewHeight).clamp(0.0, 1.0);
    final offset = _scrollOffset.clamp(0.0, maxScroll);
    if (offset <= viewHeight * 0.1) {
      return 0;
    } else if (offset >= maxScroll - viewHeight * 0.1) {
      return 2;
    } else {
      return 1;
    }
  }

  void _setScreenValue() {
    screenWidth = widget.screenWidth;
    screenHeight = widget.screenHeight;
    bottomPaddingValue = screenHeight * 0.1;
    itemWidth = screenWidth * 0.4;
    itemHeight = itemWidth;
    crossAxisCount = screenWidth ~/ itemWidth;
  }

  void _setBackgroundWidgets(double screenWidth){
    final maxWidth = screenWidth * 0.9;
    final scrollHeight = _calculateScrollHeight();
    _backgroundWidgets = [
      buildCroppedFitWidthImage(assetPath: AppAssets.imgCollectionBackgroundTop, width: maxWidth, height: scrollHeight, alignment: Alignment.topCenter),
      Image.asset(AppAssets.imgCollectionBackgroundMid, width: maxWidth, height: scrollHeight, fit: BoxFit.fill, gaplessPlayback: true),
      buildCroppedFitWidthImage(assetPath: AppAssets.imgCollectionBackgroundBottom, width: maxWidth, height: scrollHeight, alignment: Alignment.bottomCenter),
    ];
  }

  void _set4ColumnBackgroundWidgets(double screenWidth){//해당 함수는 현재 해결 하지 못한 문제로 인한 임시 조치 입니다. 추후 _setBackgroundWidgets 와 합해야 합니다.
    final maxWidth = screenWidth * 0.9;
    final scrollHeight = _calculateScrollHeight();
    _backgroundWidgets = [
      buildBackgroundImage(assetPath: AppAssets.imgCollectionBackgroundTop, width: maxWidth, alignment: Alignment.topCenter),
      Image.asset(AppAssets.imgCollectionBackgroundMid, width: maxWidth, height: scrollHeight, fit: BoxFit.fill, gaplessPlayback: true),
      buildBackgroundImage(assetPath: AppAssets.imgCollectionBackgroundBottom, width: maxWidth, alignment: Alignment.bottomCenter),
    ];
  }

  _showUnCollectedCookieMessage(){
    return SnackBar(
      content: const Text(AppStrings.unCollectedCookieMessage, textAlign: TextAlign.center, style: TextStyle(color: AppColor.mainButtonBorder),),
      backgroundColor: AppColor.mainButtonBackground,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(
          horizontal: 40, vertical: 8),
    );
  }

  double _calculateScrollHeight() {
    final rowCount = (collectionList.length / crossAxisCount).ceil();
    final scrollHeight = (itemHeight + 8) * rowCount + bottomPaddingValue;
    return scrollHeight;
  }

  List<CollectionData> _modifyList(){
    if(widget.isCollected){
      final defaultList = widget.items.toList();
      defaultList.removeWhere((data) => data.type.code == 6);
      return defaultList;
    }else{
      return widget.items;
    }
  }
}
