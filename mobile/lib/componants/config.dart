import 'package:flutter/material.dart';
import 'package:get/get.dart';

class config {
  static MediaQueryData? mediaQueryData;
  static double screenWidth = Get.context!.width;
  static double screenHeight = Get.context!.height;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    // screenWidth = MediaQuery.of(context).size.width;
    // screenHeight = Get.context!.height;
  }

  //define screen height
  static const screensmall = SizedBox(
    height: 25,
  );
  static final screenmedium = SizedBox(
    height: screenHeight * 0.05,
  );
  static final screenbig = SizedBox(
    height: screenHeight * 0.08,
  );

  //text form field border
  static const outLineBorder =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)));
  static const focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.green));
  static const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.red));

  static double pageView = screenHeight/2.64;
  static double pageViewContainer = screenHeight/3.84;
  static double pageViewTextContainer = screenHeight/8.03;


  static double height10 = screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20 = screenHeight/42.2;
  static double height25 = screenHeight/36.2;
  static double height30 = screenHeight/28.13;
  static double height45 = screenHeight/18.76;

  static double width5 = screenHeight/116.46;
  static double width10 = screenHeight/84.4;
  static double width15 = screenHeight/56.27 ;
  static double width20 = screenHeight/42.2;
  static double width30 = screenHeight/28.13;
  static double width45 = screenHeight/18.76;

  static double font14 = screenHeight/60.29;
  static double font16 = screenHeight/52.75;
  static double font18 = screenHeight/46.88;
  static double font20 = screenHeight/42.2;
  static double font22 = screenHeight/38.36;
  static double font24 = screenHeight/35.17;
  static double font26 = screenHeight/32.5;

  static double iconSize24 = screenHeight/35.17;
  static double iconSize16 = screenHeight/52.75;
  static double iconSize18 = screenHeight/46.89;
  static double iconSize20 = screenHeight/42.20;

  static double radius15 = screenHeight/56.27;
  static double radius20 = screenHeight/42.2;
  static double radius30 = screenHeight/28.13;


  static double listViewImgSize = screenWidth/3.25;
  static double listViewTextContainerSize = screenWidth/3.9;


  static double foodDetailsImg = screenHeight/2.41;

  static double customScroll = screenHeight - (foodDetailsImg - screenHeight/12.15);


}
