import 'package:flutter/material.dart';
import 'package:food_delivery/componants/config.dart';
class BigText extends StatelessWidget {
  BigText({
    super.key,
    required this.text,
    this.color = const Color(0xFF89dad0),
    this.textOverflow = TextOverflow.ellipsis,
    this.size = 0
  });
  final String text;
  final Color color;
  double size;
  TextOverflow textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: (size == 0) ? config.font20 : size,
        color: color,
        fontFamily: 'poppins',
        fontWeight: FontWeight.w400
      ),
    );
  }
}
