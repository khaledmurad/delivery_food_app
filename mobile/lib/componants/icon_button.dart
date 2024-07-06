import 'package:flutter/material.dart';
import 'package:food_delivery/componants/config.dart';

class IconBtn extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  IconBtn({super.key,
    required this.iconData,
    this.iconColor = const Color(0xFF756d54),
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size/2)
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: config.iconSize18,
      ),
    );
  }
}
