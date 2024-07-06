import 'package:flutter/material.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/componants/config.dart';

class IconAndText extends StatelessWidget {
  IconAndText({super.key,required this.icon,required this.iconColor,required this.text});
  IconData icon;
  String text;
  Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,size: config.iconSize24,),
        SizedBox(width: 5,),
        SmallText(text: text,)
      ],
    );
  }
}
