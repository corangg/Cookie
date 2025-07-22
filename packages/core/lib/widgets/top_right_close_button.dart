import 'package:flutter/material.dart';

class TopRightCloseButton extends StatelessWidget {
  final double iconSize;
  final double iconTop;
  final double iconRight;
  final Color iconColor;
  final VoidCallback? onTap;

  const TopRightCloseButton({
    super.key,
    this.iconSize = 32,
    this.iconTop = 24,
    this.iconRight = 24,
    this.iconColor = Colors.white,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: iconTop,
      right: iconRight,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(Icons.close, size: iconSize, color: iconColor),
      ),
    );
  }
}