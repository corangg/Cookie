import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';

class CollectionWidget extends StatefulWidget {
  final List<CollectionData> items;
  final double screenWidth;
  final double screenHeight;
  final bool isCollected;

  const CollectionWidget({
    super.key,
    required this.items,
    required this.screenWidth,
    required this.screenHeight,
    required this.isCollected
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
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    collectionList = _modifyList();
    _setBackgroundWidgets(screenWidth);
    return _scrollBody();
  }

  Widget _scrollBody(){
    final topPaddingValue = screenHeight * 0.04;
    final maxWidth = screenWidth * 0.9;

    final scrollHeight = _calculateScrollHeight();
    final viewHeight   = screenHeight - topPaddingValue/*( + bottomPaddingValue)*/;
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
              left: screenWidth * 0,
              right: screenWidth * 0,
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
      itemBuilder: (_, index) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _itemCollectionData(collectionList[index]),
          ),
    );
  }

  Widget _itemCollectionData(CollectionData data) {
    final openCookieImg = AppAssets.imgTypeOpenCookie(data.type.code);
    return AspectRatio(
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
