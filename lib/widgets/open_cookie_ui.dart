import 'dart:async';

import 'package:cookie/viewmodel/oven_screen_view_model.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:core/values/app_size.dart';
import 'package:core/values/app_string.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenCookieUI extends StatefulWidget {
  final OpenCookieUIData openCookieUIData;
  final DateCookieInfo cookieInfo;
  final VoidCallback onClose;

  const OpenCookieUI({
    super.key,
    required this.openCookieUIData,
    required this.cookieInfo,
    required this.onClose,
  });

  @override
  State<OpenCookieUI> createState() => _OpenCookieUI();
}

class _OpenCookieUI extends State<OpenCookieUI> {
  late final OvenScreenViewModel vm;

  final Map<int, Offset> _activePointers = {};
  Offset? _firstPointerStart;
  Offset? _secondPointerStart;

  int   _animIndex    = 0;
  bool  _isAnimating  = false;
  Timer? _animTimer;
  bool _isOpened = false;

  List<String> get  _openCookieImages => [
    widget.openCookieUIData.cookieStateData.catchCookie,
    widget.openCookieUIData.cookieStateData.crackCookie,
    widget.openCookieUIData.cookieStateData.halfOpenCookie,
    widget.openCookieUIData.cookieStateData.openCookie,
  ];


  @override
  void initState() {
    _isOpened = widget.cookieInfo.isOpened;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    vm = context.read<OvenScreenViewModel>();
  }

  @override
  void dispose() {
    _animTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Positioned.fill(
        child: Container(
          color: AppColor.translucentBackground,
          child: _isOpened ? _buildOpenedView() : _buildPreOpenView()
        )
    );
  }

  Widget _buildOpenedView() {
    return Stack(
      children: [
        Center(child: Image.asset(
          _openCookieImages.last,
          width: widget.openCookieUIData.screenWidth,
          height: widget.openCookieUIData.screenHeight,
          fit: BoxFit.contain,
        )),
        Align(
          alignment: const Alignment(0, -0.6),
          child: _messageView(),
        ),
        _closeButton(),
        _showOkButton()
      ],
    );
  }
  Widget _messageView() {
    final no = vm.newCookieNo;
    final list = AppStrings.getCookieMessageList(widget.cookieInfo.type.code);
    final message = (no == null || no >= list.length) ? AppStrings.errorCookieMessage : list[no];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.openCookieUIData.screenWidth * 1,
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
            message,//
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildPreOpenView(){
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp:   _onPointerUp,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              _isAnimating ? _openCookieImages[_animIndex] : _openCookieImages[0],
              width:  widget.openCookieUIData.screenWidth,
              height: widget.openCookieUIData.screenHeight,
              fit:    BoxFit.contain,
            ),
          ),
          _closeButton(),
        ],
      ),
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    _activePointers[event.pointer] = event.position;
    if (_activePointers.length == 2) {
      final pts = _activePointers.values.toList();
      _firstPointerStart  = pts[0];
      _secondPointerStart = pts[1];
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_activePointers.length == 2 && !_isAnimating) {
      _activePointers[event.pointer] = event.position;
      final pts = _activePointers.values.toList();
      final dx1 = pts[0].dx - (_firstPointerStart?.dx ?? 0);
      final dx2 = (_secondPointerStart?.dx ?? 0) - pts[1].dx;

      if (dx1 > 30 && dx2 > 30) {
        _startOpenAnimation();
        _activePointers.clear();
      }
    }
  }

  void _onPointerUp(PointerUpEvent e) {
    _activePointers.remove(e.pointer);
  }

  void _startOpenAnimation() {
    if (_isAnimating) return;
    _isAnimating = true;
    _animIndex   = 0;
    _animTimer?.cancel();

    _animTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _animIndex++;
        if (_animIndex >= _openCookieImages.length - 1) {
          _isOpened = true;
          timer.cancel();
          vm.updateDateCookieInfo(widget.cookieInfo);
        }
      });
    });
  }

  Widget _closeButton() {
    return Positioned(
      top: 24,
      right: 24,
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.onClose.call();
          });
        },
        child: const Icon(Icons.close, size: 32, color: Colors.white),
      ),
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