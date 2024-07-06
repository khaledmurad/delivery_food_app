import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  SmallText({
    super.key,
    required this.text,
    this.color = const Color(0xFFccc7c5),
    // this.textOverflow = TextOverflow.ellipsis,
    this.size = 12
  });
  final String text;
  final Color color;
  double size;
  // TextOverflow textOverflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // maxLines: 1,
      // overflow: textOverflow,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontFamily: 'poppins',
      ),
    );
  }
}
