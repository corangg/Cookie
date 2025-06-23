import 'dart:async';

import 'package:core/values/app_color.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';

class OpenCookieUI extends StatefulWidget {
  final OpenCookieUIData openCookieUIData;
  final VoidCallback onClose;

  const OpenCookieUI({
    super.key,
    required this.openCookieUIData,
    required this.onClose,
  });

  @override
  State<OpenCookieUI> createState() => _OpenCookieUI();
}

class _OpenCookieUI extends State<OpenCookieUI> {
  final Map<int, Offset> _activePointers = {};
  Offset? _firstPointerStart;
  Offset? _secondPointerStart;
  bool isOpened = false;
  int openImageIndex = 1;
  Timer? openImageTimer;

  List<String> openCookieImages() {
    return [
      widget.openCookieUIData.cookieStateData.catchCookie,
      widget.openCookieUIData.cookieStateData.crackCookie,
      widget.openCookieUIData.cookieStateData.halfOpenCookie,
      widget.openCookieUIData.cookieStateData.openCookie,
    ];
  }

  void startOpenAnimation() {
    final images = openCookieImages();

    openImageIndex = 1;
    openImageTimer?.cancel();

    openImageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        openImageIndex++;
        if (openImageIndex >= images.length) {
          openImageTimer?.cancel();
        }
      });
    });
  }

  void startOpenCookie(PointerMoveEvent event) {
    if (_activePointers.length == 2) {
      _activePointers[event.pointer] = event.position;

      final points = _activePointers.values.toList();
      final delta1 = points[0].dx - (_firstPointerStart?.dx ?? 0);
      final delta2 = (_secondPointerStart?.dx ?? 0) - points[1].dx;

      if (delta1 > 50 && delta2 > 50 && !isOpened) {
        setState(() {
          isOpened = true;
          openImageIndex = 1;
          startOpenAnimation();
        });
        _activePointers.clear();
        _firstPointerStart = null;
        _secondPointerStart = null;
      }
    }
  }

  Widget showOpenCookieUi() {
    final String asset = !isOpened
        ? openCookieImages()[0]
        : openImageIndex < openCookieImages().length
        ? openCookieImages()[openImageIndex]
        : openCookieImages().last;

    return Center(
      child: Image.asset(
        asset,
        width: widget.openCookieUIData.screenWidth,
        height: widget.openCookieUIData.screenHeight,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget closeButton() {
    return Positioned(
      top: 24,
      right: 24,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOpened = false;
            widget.onClose.call();
          });
        },
        child: const Icon(Icons.close, size: 32, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    openImageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Listener(onPointerDown: (event) {
          _activePointers[event.pointer] = event.position;
          if (_activePointers.length == 2) {
            final points = _activePointers.values.toList();
            _firstPointerStart = points[0];
            _secondPointerStart = points[1];
          }
        },
            onPointerMove: (event) {
              startOpenCookie(event);
            },
            onPointerUp: (event) {
              _activePointers.remove(event.pointer);
            },
            child: Container(
                color: AppColor.translucentBackground,
                child: Stack(
                  children: [
                    showOpenCookieUi(),
                    closeButton()
                  ],
                )
            )
        )
    );
  }
}