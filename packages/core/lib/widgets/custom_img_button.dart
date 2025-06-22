import 'package:core/values/app_assets.dart';
import 'package:flutter/material.dart';

class CustomImageButton extends StatefulWidget {
  final String imgAssets;
  final bool isOpened;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomImageButton({
    super.key,
    required this.imgAssets,
    required this.isOpened,
    required this.width,
    required this.height,
    this.onPressed,
  });

  @override
  State<CustomImageButton> createState() => _CustomImageButton();
}

class _CustomImageButton extends State<CustomImageButton> {
  bool _isClicked = false;

  void _handleClick() {
    setState(() {
      _isClicked = true;
    });
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleClick,
      child: Image.asset(
        widget.imgAssets,
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
