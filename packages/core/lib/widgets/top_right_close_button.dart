import 'package:flutter/material.dart';

class TopRightCloseButton extends StatelessWidget {
  final VoidCallback? onTap;

  const TopRightCloseButton({
    super.key,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 24,
      right: 24,
      child: GestureDetector(
        onTap: onTap,
        child: const Icon(Icons.close, size: 32, color: Colors.white),
      ),
    );
  }
}