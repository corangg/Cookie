import 'dart:async';

import 'package:cookie/widgets/open_cookie_ui.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:core/widgets/custom_img_button.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';

class OvenScreen extends StatefulWidget {
  const OvenScreen({super.key});

  @override
  State<OvenScreen> createState() => _OvenScreen();
}

class _OvenScreen extends State<OvenScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  final List<CookieImageAssetsData> cookieImageDataList = [
    CookieImageAssetsData(
        AppAssets.imgCookieCheering1, AppAssets.imgCookieCheering2,
        AppAssets.imgCookieCheering3, AppAssets.imgCookieCheering4,
        AppAssets.imgCookieCheering5, AppAssets.imgCookieCheering6)
  ];

  int _typeOverlayImage = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.mainBackground,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          SafeArea(child: _buildBody(context)),
          if(0 <= _typeOverlayImage && _typeOverlayImage < cookieImageDataList.length)
            OpenCookieUI(openCookieUIData: OpenCookieUIData(
                screenWidth,
                screenHeight,
                cookieImageDataList[_typeOverlayImage]), onClose: () {
              setState(() {
                _typeOverlayImage = -1;
                // 깨진 이미지로 변경 해야함
              });
            })
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.mainBackground,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Oven',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double maxWidth = screenWidth * 0.8;
    final double maxHeight = screenHeight * 0.8;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
      child: Center(
        child: SizedBox(
          width: maxWidth, height: maxHeight,
          child: _buildAnimatedContent(maxWidth, maxHeight)
        ),
      ),
    );
  }

  Widget _buildAnimatedContent(double maxWidth, double maxHeight) {
    return SlideTransition(
        position: _offsetAnimation, child: _ui(maxWidth, maxHeight));
  }

  Widget _ui(double maxWidth, double maxHeight) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: _buildTrayImage(maxWidth, maxHeight),
        ),
        ..._cookieButtonList(maxWidth, maxHeight),
      ],
    );
  }

  List<Widget> _cookieButtonList(double maxWidth, double maxHeight) {
    final List<CookieButtonData> cookieButtonDataList = [
      CookieButtonData(top: maxHeight * 0.15, left: maxWidth * 0.15, asset: cookieImageDataList[0].trayCookie),
      CookieButtonData(top: maxHeight * 0.15, left: maxWidth * 0.55, asset: AppAssets.imgCookieComfort1),
      CookieButtonData(top: maxHeight * 0.30, left: maxWidth * 0.15, asset: AppAssets.imgCookiePassion1),
      CookieButtonData(top: maxHeight * 0.30, left: maxWidth * 0.55, asset: AppAssets.imgCookieSermon1),
      CookieButtonData(top: maxHeight * 0.45, left: (maxWidth * 0.7) / 2, asset: AppAssets.imgCookieNormal1),
    ];
    return cookieButtonDataList.asMap().entries.map((entry) {
      final int index = entry.key;
      final CookieButtonData btn = entry.value;
      return Positioned(
        top: btn.top,
        left: btn.left,
        right: btn.right,
        child: CustomImageButton(imgAssets: btn.asset,
          isOpened: false,
          width: maxWidth * 0.3,
          height: maxHeight * 0.3,
          onPressed: () {
            setState(() {
              _typeOverlayImage = index;
            });
          },
        ),
      );
    }).toList();
  }

  Widget _buildTrayImage(double imgWidth, double imgHeight) {
    return SizedBox(
      width: imgWidth,
      height: imgHeight,
      child: Image.asset(AppAssets.imgTray, fit: BoxFit.contain),
    );
  }
}
