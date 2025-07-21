import 'dart:async';

import 'package:cookie/viewmodel/oven_screen_view_model.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:core/values/app_size.dart';
import 'package:core/values/app_string.dart';
import 'package:core/widgets/top_right_close_button.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenCollectionUI extends StatefulWidget {
  final CollectionData collectionData;
  final VoidCallback onClose;

  const OpenCollectionUI({
    super.key,
    required this.collectionData,
    required this.onClose,
  });

  @override
  State<OpenCollectionUI> createState() => _OpenCollectionUI();
}

class _OpenCollectionUI extends State<OpenCollectionUI> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildOpenedView();
  }

  Widget _buildOpenedView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
            top: screenHeight*0.05,
            left: screenWidth*0.1,
            right: screenWidth*0.1,
            child: Image.asset(AppAssets.imgTypeOpenCookie(widget.collectionData.type.code), width: screenWidth*0.8,fit: BoxFit.fitWidth,)),
        Positioned.fill(child: Container(
            color: AppColor.translucentBackground
        )),
        Align(
          alignment: const Alignment(0, -0.8),
          child: _messageView(),
        ),
        _closeButton(),
        _showOkButton()
      ],
    );
  }
  Widget _messageView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: screenWidth * 1,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.imgMessagePaper),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.cookieMessagePadding,
            vertical: AppSize.cookieMessagePadding,
          ),
          child: Text(
            _setCollectionText(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  String _setCollectionText(){
    final no = widget.collectionData.no;
    final list = AppStrings.getCookieMessageList(widget.collectionData.type.code);
    final message = (no > list.length) ? AppStrings.errorCookieMessage : list[no-1];
    final data = widget.collectionData.date;
    final cookieType = AppStrings.getCookieType(widget.collectionData.type.code);

    final messageText = '${data.year}년 ${data.month}월 ${data.day}일의 $cookieType\n\n$message';
    return messageText;
  }

  Widget  _closeButton(){
    return TopRightCloseButton(
      onTap: (){
        setState(() {
          widget.onClose.call();
        });
      },
    );
  }

  Widget _showOkButton() {
    return Align(
      alignment: const Alignment(0.0, 0.5),
      child: ElevatedButton(
        onPressed: (){
          setState(() {
            widget.onClose.call();
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
}