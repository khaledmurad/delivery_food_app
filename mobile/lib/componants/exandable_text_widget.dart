import 'package:flutter/material.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/utils/colors.dart';
class ExandableText extends StatefulWidget {
  const ExandableText({super.key, required this.text});
  final String text;

  @override
  State<ExandableText> createState() => _ExandableTextState();
}

class _ExandableTextState extends State<ExandableText> {
  late String firstText;
  late String secondText;

  bool hintText = true;
  double textHeight = config.screenHeight/5.63;


  @override
  void initState() {
    super.initState();
    if(widget.text.length > textHeight){
      firstText = widget.text.substring(0 , textHeight.toInt());
      secondText = widget.text.substring(textHeight.toInt()+1 , widget.text.length);
    }else{
      firstText = widget.text;
      secondText = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return (secondText.isEmpty)? SmallText(text: firstText,size: config.font16,color: AppColors.paraColor,):
      Column(
        children: [
          SmallText(text: (hintText)? (firstText+"..."):(firstText+secondText),size: config.font16,color: AppColors.paraColor,),
          InkWell(
            child: Row(
              children: [
                SmallText(text: (hintText)?"Show more": "Show less",color: AppColors.mainColor),
                Icon((hintText)?Icons.arrow_drop_down_rounded:Icons.arrow_drop_up_rounded,color: AppColors.mainColor,)
              ],
            ),
            onTap: (){
              setState(() {
                hintText = !hintText;
              });
            },
          )
        ],
      );
  }
}
