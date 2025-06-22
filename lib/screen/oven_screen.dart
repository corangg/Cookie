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

class _OvenScreen extends State<OvenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainBackground,
      appBar: _buildAppBar(),
      body: SafeArea(child: _buildBody(context)),
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

    final List<CookieButtonData> cookieButtonDataList = [
      CookieButtonData(top: maxHeight * 0.17, left: maxWidth * 0.15, asset: AppAssets.imgCookieNormal1),
      CookieButtonData(top: maxHeight * 0.17, left: maxWidth * 0.55, asset: AppAssets.imgCookieNormal1),
      CookieButtonData(top: maxHeight * 0.34, left: maxWidth * 0.15, asset: AppAssets.imgCookieNormal1),
      CookieButtonData(top: maxHeight * 0.34, left: maxWidth * 0.55, asset: AppAssets.imgCookieNormal1),
      CookieButtonData(top: maxHeight * 0.51, left: (maxWidth * 0.7) / 2, asset: AppAssets.imgCookieNormal1),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
      child: Center(child: Stack(
        alignment: Alignment.center,
        children: [
          _buildTrayImage(maxWidth, maxHeight),
          ...cookieButtonDataList.map((btn) {
            return Positioned(
              top: btn.top,
              left: btn.left,
              right: btn.right,
              child: CustomImageButton(imgAssets: btn.asset,
                isOpened: false,
                width: maxWidth * 0.3,
                height: maxHeight * 0.3,
                onPressed: () {
                  print("test");
                },
              ),
            );
          })
        ],
      ),),
    );
  }

  Widget _buildTrayImage(double imgWidth, double imgHeight) {
    return SizedBox(
      width: imgWidth,
      height: imgHeight,
      child: Image.asset(AppAssets.imgTray, fit: BoxFit.contain),
    );
  }
}
