import 'package:cookie/di/injection.dart';
import 'package:cookie/notification/notification.dart';
import 'package:cookie/viewmodel/oven_screen_view_model.dart';
import 'package:cookie/widgets/cookie_button_list.dart';
import 'package:cookie/widgets/open_cookie_ui.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:core/values/app_id.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';
import 'package:core/util/util.dart';
import 'package:core/values/app_string.dart';
import 'package:timezone/timezone.dart' as tz;

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

class _OvenScreenBodyState extends State<_OvenScreenBody> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  late final OvenScreenViewModel viewModel;

  int _selectCookieType = -1;
  DateTime _midNightTime = getTodayMidnight();

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
    CookieImageAssetsData(
      AppAssets.imgCookiePassion1,
      AppAssets.imgCookiePassion2,
      AppAssets.imgCookiePassion3,
      AppAssets.imgCookiePassion4,
      AppAssets.imgCookiePassion5,
      AppAssets.imgCookiePassion6,
    )
  ];

  @override
  void initState() {
    super.initState();
    viewModel = sl<OvenScreenViewModel>();
    setMidNightNotificationMessage();
    testAlarm();
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
    return Scaffold(
      backgroundColor: AppColor.mainBackground,
      appBar: _buildAppBar(),
      body: SafeArea(
          child: Consumer<OvenScreenViewModel>(
              builder: (_, vm, _) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _buildBody();
              }
          )
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

  Widget _buildBody() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [

      Positioned(
          top: 0,
          right: screenWidth*0.05,
          child: _countDownTimer()),
      _buildAnimatedContent(screenWidth, screenHeight),
      if (0 <= _selectCookieType && _selectCookieType < cookieImageDataList.length)
        OpenCookieUI(
            openCookieUIData: OpenCookieUIData(screenWidth, screenHeight, cookieImageDataList[_selectCookieType],),
            cookieInfo: viewModel.cookie.infos[_selectCookieType],
            onClose: () {
              setState(() {
                _selectCookieType = -1;
              });
            })
    ]);
  }

  Widget _buildAnimatedContent(
    double screenWidth,
    double screenHeight
  ) {
    final double maxWidth = screenWidth * 0.8;
    final double maxHeight = screenHeight * 0.8;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
      child: Center(
        child: SizedBox(
          width: maxWidth,
          height: maxHeight,
          child: SlideTransition(position: _offsetAnimation, child: _trayUI(maxWidth, maxHeight))
        ),
      ),
    );
  }

  Widget _trayUI(double maxWidth, double maxHeight) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(child: _buildTrayImage(maxWidth, maxHeight)),
        CookieButtonList(maxWidth: maxWidth,
          maxHeight: maxHeight,
          cookieImageDataList: cookieImageDataList,
          onCookieSelected: (type) {
            setState(() {
              _selectCookieType = type;
            });
          },
        )
      ]
      ,
    );
  }

  Widget _buildTrayImage(double imgWidth, double imgHeight) {
    return SizedBox(
      width: imgWidth,
      height: imgHeight,
      child: Image.asset(AppAssets.imgTray, fit: BoxFit.contain),
    );
  }

  Widget _countDownTimer(){
    final endTimestamp = _midNightTime.millisecondsSinceEpoch;
    return CountdownTimer(
      endTime: endTimestamp,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          return const SizedBox.shrink();
        }
        final hours = time.hours?.toString().padLeft(2, '0') ?? "00";
        final min   = time.min?.toString().padLeft(2, '0')   ?? "00";
        final sec   = time.sec?.toString().padLeft(2, '0')   ?? "00";
        return Text("$hours:$min:$sec",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: AppColor.countDown),
        );
      },
      onEnd: (){
        setState(() {
          _midNightTime = getTodayMidnight();
          viewModel.upsertTodayCookie();
          ScaffoldMessenger.of(context).showSnackBar(
            //추후 노티피케이션 메세지 발생하도록 해야할듯?
            showUpdateCookieMessage()//도 오버레이 메세지로 ui 띄우는게 맞을듯?
          );
        });
      },
    );
  }

  showUpdateCookieMessage() {
    return SnackBar(
      content: const Text(AppStrings.updateCookieMessage, textAlign: TextAlign.center, style: TextStyle(color: AppColor.mainButtonBorder),),
      backgroundColor: AppColor.mainButtonBackground,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(
          horizontal: 40, vertical: 8),
    );
  }

  setMidNightNotificationMessage(){
    /*final now = tz.TZDateTime.now(tz.local);
    final nextMidnight = tz.TZDateTime(
        tz.local, now.year, now.month, now.day,02,24
    );

    NotificationService().schedule(
        id: AppID.midNightNotificationID,
        title: AppStrings.updateCookieTitleMessage,
        body: AppStrings.updateCookieTitleMessage,
        scheduledAt: nextMidnight);*/
    final when = DateTime.now().add(const Duration(minutes: 1));
    NotificationService().scheduleAtDateTime(
      id: 1057,
      title: 'DateTime 예약 테스트',
      body: '1분 뒤에 울리나요?',
      scheduledAt: when,
    );
  }

  testAlarm() async{
    await NotificationService().show(
      id: 42,
      title: '즉시 알림 테스트',
      body: '이게 보이면 권한·채널은 OK',
    );
  }

}
