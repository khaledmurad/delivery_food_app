import 'dart:core';
import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:get/get.dart';
import 'package:food_delivery/componants/config.dart';

void getSnackBar(String message, {bool isError = true,String title='Error'}){
    Get.snackbar(
       message, title,
        messageText: Text(message,style: TextStyle(
          fontSize: config.font16,color: Colors.white
        ),),
      titleText: BigText(text: title,color: Colors.white,),
      backgroundColor: isError?Colors.redAccent:Colors.green,
      borderRadius: config.radius15,
      snackPosition: SnackPosition.TOP,
    );
}