import 'package:flutter/material.dart';
import 'package:food_delivery/componants/icon_and_text.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/utils/colors.dart';
import 'bigtext.dart';
import 'config.dart';

class ColumnDetails extends StatelessWidget {
  final String text;
  final int stars;
  final double? textSize;
  ColumnDetails({super.key, required this.text, this.textSize=0, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,color: Colors.black,size: textSize!),
        SizedBox(height: config.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {return Icon(Icons.star,color: AppColors.mainColor,size: 15,);}),
            ),
            SizedBox(width: config.width10,),
            SmallText(text: "${stars.toDouble()}",),
            SizedBox(width: config.width10,),
            SmallText(text: "365",),
            SizedBox(width: config.width5,),
            SmallText(text: "comments",),
          ],
        ),
        SizedBox(height: config.height10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(icon: Icons.circle,text: "Normal",iconColor: AppColors.iconColor2),
            IconAndText(icon: Icons.location_on_rounded,text: "1 KM",iconColor: AppColors.mainColor),
            IconAndText(icon: Icons.access_time_rounded,text: "40 min",iconColor: Colors.redAccent),
          ],
        )
      ],
    );
  }
}
