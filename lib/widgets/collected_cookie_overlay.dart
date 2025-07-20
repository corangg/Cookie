import 'package:core/widgets/top_right_close_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
class CollectedCookieOverlay extends StatelessWidget{
  final VoidCallback? onTap;

  const CollectedCookieOverlay({
    super.key,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopRightCloseButton(onTap: () {

          },)
        ],
      ),
    );
  }

*/
/*


  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: 50,
        right: 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '이것은 오버레이입니다',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();

    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    //Overlay.of(context).insert(_overlayEntry!);
  }

  *//*

}*/
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OverlayEntry? _overlayEntry;

  // ① OverlayEntry 생성 함수
  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: 50,
        right: 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '이것은 오버레이입니다',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  // ② 버튼 클릭 시 오버레이를 토글
  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overlay 예제')),
      body: Center(
        child: ElevatedButton(
          onPressed: _toggleOverlay,
          child: const Text('오버레이 띄우기/감추기'),
        ),
      ),
    );
  }
}