import 'package:cookie/di/injection.dart';
import 'package:cookie/main.dart';
import 'package:cookie/values/assets.dart';
import 'package:cookie/viewmodel/more_screen_view_model.dart';
import 'package:cookie/widgets/show_collection_late_overlay_body.dart';
import 'package:core/base/base_screen.dart';
import 'package:core/util/util.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:core/values/app_string.dart';
import 'package:core/widgets/custom_img_button.dart';
import 'package:core/widgets/top_right_close_button.dart';
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

class _MoreContentState extends State<MoreContent> with SingleTickerProviderStateMixin, RouteAware {
  OverlayEntry? _overlayEntry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _overlayRemove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return _profileListView(CookieAssets.moreItemList, screenWidth, screenHeight);
  }

  Widget _profileListView(List<MoreItemData> items, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
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
              _showOverlay(item.itemType.code);
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

  void _showOverlay(int type) {
    if (_overlayEntry != null)  _overlayRemove();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = getAppBarHeight(context);
    final topBlank = statusBarHeight + appBarHeight + 10;
    final overlayHeight = screenHeight*0.8 - topBlank;

    final Widget overlayBody;
    switch (type) {
      case 2 :{overlayBody = _showThemeOverlay(screenWidth, screenHeight);break;}
      case 3 :{overlayBody = ShowCollectionLateOverlayBody(
        overlayWidth: screenWidth*0.8,
        overlayHeight: overlayHeight,
        viewModel: widget.viewModel,);break;}
      case 4 :{overlayBody = _showAboutApp(screenWidth, screenHeight);break;}
      case _ :throw ArgumentError('알 수 없는 Overlay 타입: $type');
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
          top: statusBarHeight + appBarHeight + 10,
          left: screenWidth * 0.1,
          right: screenWidth * 0.1,
          bottom: screenHeight * 0.2,
          child: Material(
              color: Colors.transparent,
              child: Positioned.fill(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColor.defaultOverlay,
                      border: Border.all(
                          color: AppColor.defaultOverlayBorder, width: 6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        overlayBody,
                        TopRightCloseButton(
                          iconSize: 24, iconTop: 0, iconRight: 0,iconColor: AppColor.defaultOverlayBorder,
                          onTap: () {
                            setState(() {
                              _overlayRemove();
                            });
                          },
                        ),
                        _showOkButton()
                      ],
                    )
                ),
              )
          )
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _showThemeOverlay(double screenWidth, double screenHeight){
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.01,),
        Align(
          alignment: Alignment.center,
          child: Text('테마', style: TextStyle(color: AppColor.mainTextColor, fontSize: 18, fontWeight: FontWeight.bold,),),
        ),
      ],
    );
  }

  Widget _showAboutApp(double screenWidth, double screenHeight){
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.01,),
        Align(
          alignment: Alignment.center,
          child: Text('앱 정보', style: TextStyle(color: AppColor.mainTextColor, fontSize: 18, fontWeight: FontWeight.bold,),),
        ),
      ],
    );
  }

  Widget _showOkButton() {
    return Align(
      alignment: const Alignment(0.0, 0.95),
      child: ElevatedButton(
        onPressed: (){
          setState(() {
            _overlayRemove();
          });
        }, style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.mainButtonBackground,
        foregroundColor: AppColor.mainButtonBorder,
        side: const BorderSide(color: AppColor.mainButtonBorder, width: 2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
        child: const Text(AppStrings.buttonOk),
      ),
    );
  }

  void _overlayRemove(){
    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}