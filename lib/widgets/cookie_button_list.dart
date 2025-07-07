import 'package:cookie/viewmodel/oven_screen_view_model.dart';
import 'package:core/values/app_color.dart';
import 'package:core/widgets/custom_img_button.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:core/values/app_string.dart';

class CookieButtonList extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final List<CookieImageAssetsData> cookieImageDataList;
  final ValueChanged<int> onCookieSelected;

  const CookieButtonList({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
    required this.cookieImageDataList,
    required this.onCookieSelected
  });

  @override
  State<CookieButtonList> createState() => _CookieButtonList();
}

class _CookieButtonList extends State<CookieButtonList>{
  late final OvenScreenViewModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = context.read<OvenScreenViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final list = _setCookieButtonList(widget.maxWidth, widget.maxHeight);

    return Stack(
      children: list.asMap().entries.map((entry){
        final index = entry.key;
        final btn = entry.value;
        final imgAsset = btn.isOpened
            ? widget.cookieImageDataList[index].crushCookie
            : widget.cookieImageDataList[index].trayCookie;
        return Positioned(
            top: btn.top,
            left: btn.left,
            right: btn.right,
            child: CustomImageButton(
              imgAssets: imgAsset,
              width: widget.maxWidth * 0.3,
              height: widget.maxHeight * 0.3,
              onPressed: () {
                //if()
                final cookieData = viewModel.cookie;
                final type = CookieType.fromCode(index +1);
                if(cookieData.infos[index].isOpened){
                  viewModel.setNewCookieNo(cookieData.infos[index].no);
                }else{
                  viewModel.generateNewCookieNo(type, AppStrings.getCookieMessageList(type.code).length);
                }
                if (viewModel.newCookieNo == -1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      showAllCollectionMessage()
                  );
                } else {
                  widget.onCookieSelected(index);
                }
              },
            )
        );
      }).toList()
    );
  }

  bool _isOpenedFor(CookieType type) {
    final cookieData = viewModel.cookie;
    final info = cookieData.infos.firstWhere(
          (i) => i.type.runtimeType == type.runtimeType,
      orElse: () => DateCookieInfo(type: type, isOpened: false, no: -1),
    );
    return info.isOpened;
  }

  List<CookieButtonData> _setCookieButtonList(double width, double height) {
    return [
      CookieButtonData(top: height * 0.15, left: width * 0.15, isOpened: _isOpenedFor(const CookieType.cheering()),),
      CookieButtonData(top: height * 0.15, left: width * 0.55, isOpened: _isOpenedFor(const CookieType.comfort()),),
      CookieButtonData(top: height * 0.30, left: width * 0.15, isOpened: _isOpenedFor(const CookieType.passion()),),
      /*
      CookieButtonData(top: maxHeight * 0.30, left: maxWidth * 0.55, isOpened: cookieData.isSermonOpened),
      CookieButtonData(top: maxHeight * 0.45, left: (maxWidth * 0.7) / 2, isOpened: cookieData.isRandomsOpened),*/

    ];
  }

  showAllCollectionMessage() {
    return SnackBar(
      content: const Text(AppStrings.allCollectionMessage, textAlign: TextAlign.center, style: TextStyle(color: AppColor.mainButtonBorder),),
      backgroundColor: AppColor.mainButtonBackground,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(
          horizontal: 85, vertical: 8),
    );
  }
}