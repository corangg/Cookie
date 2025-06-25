import 'package:cookie/di/injection.dart';
import 'package:cookie/viewmodel/oven_screen_view_model.dart';
import 'package:cookie/widgets/open_cookie_ui.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:core/widgets/custom_img_button.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OvenScreen extends StatelessWidget {
  const OvenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OvenScreenViewModel>(
      create: (_) => sl<OvenScreenViewModel>(),
      child: const _OvenScreenBody(),
    );
  }
}

class _OvenScreenBody extends StatefulWidget {
  const _OvenScreenBody({super.key});

  @override
  State<_OvenScreenBody> createState() => _OvenScreenBodyState();
}

class _OvenScreenBodyState extends State<_OvenScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  late final OvenScreenViewModel viewModel;

  int _typeOverlayImage = -1;

  final List<CookieImageAssetsData> cookieImageDataList = [
    CookieImageAssetsData(
      AppAssets.imgCookieCheering1,
      AppAssets.imgCookieCheering2,
      AppAssets.imgCookieCheering3,
      AppAssets.imgCookieCheering4,
      AppAssets.imgCookieCheering5,
      AppAssets.imgCookieCheering6,
    ),
    CookieImageAssetsData(
      AppAssets.imgCookieComfort1,
      AppAssets.imgCookieComfort2,
      AppAssets.imgCookieComfort3,
      AppAssets.imgCookieComfort4,
      AppAssets.imgCookieComfort5,
      AppAssets.imgCookieComfort6,
    ),
  ];

  @override
  void initState() {
    super.initState();
    viewModel = sl<OvenScreenViewModel>();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
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
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<OvenScreenViewModel>(
              builder: (_, vm, _) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _buildBody(
                  context,
                  screenWidth,
                  screenHeight,
                  vm.cookie,
                );
              },
            ),
            if (0 <= _typeOverlayImage &&
                _typeOverlayImage < cookieImageDataList.length)
              OpenCookieUI(
                openCookieUIData: OpenCookieUIData(
                  screenWidth,
                  screenHeight,
                  cookieImageDataList[_typeOverlayImage],
                ),
                onClose: () {
                  setState(() {
                    _typeOverlayImage = -1;
                    // 깨진 이미지로 변경 해야함
                  });
                },
              ),
          ],
        ),
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

  Widget _buildBody(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    CookieData cookieData,
  ) {
    final double maxWidth = screenWidth * 0.8;
    final double maxHeight = screenHeight * 0.8;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
      child: Center(
        child: SizedBox(
          width: maxWidth,
          height: maxHeight,
          child: _buildAnimatedContent(maxWidth, maxHeight, cookieData),
        ),
      ),
    );
  }

  Widget _buildAnimatedContent(
    double maxWidth,
    double maxHeight,
    CookieData cookieData,
  ) {
    return SlideTransition(
      position: _offsetAnimation,
      child: _ui(maxWidth, maxHeight, cookieData),
    );
  }

  Widget _ui(double maxWidth, double maxHeight, CookieData cookieData) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(child: _buildTrayImage(maxWidth, maxHeight)),
        ..._cookieButtonList(maxWidth, maxHeight, cookieData),
      ],
    );
  }

  List<Widget> _cookieButtonList(
    double maxWidth,
    double maxHeight,
    CookieData cookieData,
  ) {
    final List<CookieButtonData> cookieButtonDataList = [
      CookieButtonData(
        top: maxHeight * 0.15,
        left: maxWidth * 0.15,
        isOpened: cookieData.isCheeringOpened,
      ),
      CookieButtonData(
        top: maxHeight * 0.15,
        left: maxWidth * 0.55,
        isOpened: cookieData.isComportOpened,
      ),
      /*  CookieButtonData(top: maxHeight * 0.30, left: maxWidth * 0.15, isOpened: cookieData.isPassionOpened),
      CookieButtonData(top: maxHeight * 0.30, left: maxWidth * 0.55, isOpened: cookieData.isSermonOpened),
      CookieButtonData(top: maxHeight * 0.45, left: (maxWidth * 0.7) / 2, isOpened: cookieData.isRandomsOpened),*/
    ];

    String cookieAssets(int index) {
      if (cookieButtonDataList[index].isOpened) {
        return cookieImageDataList[index].openCookie;
      } else {
        return cookieImageDataList[index].trayCookie;
      }
    }

    return cookieButtonDataList.asMap().entries.map((entry) {
      final int index = entry.key;
      final CookieButtonData btn = entry.value;
      return Positioned(
        top: btn.top,
        left: btn.left,
        right: btn.right,
        child: CustomImageButton(
          imgAssets: cookieAssets(index),
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
