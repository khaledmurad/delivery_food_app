import 'package:flutter/material.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/utils/colors.dart';

class SignPageContainers extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData iconData;
  final bool obscure ;
  final TextInputType textInputType ;
  const SignPageContainers({super.key, required this.controller,
    required this.hintText, this.obscure = false, required this.iconData,
    this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: config.height20*3.5,
      margin: EdgeInsets.symmetric(horizontal: config.width20),
      padding: EdgeInsets.symmetric(horizontal: config.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(config.radius30),
          boxShadow:[
            BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset(5, 5),
                blurRadius: 4
            )
          ]
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData,color: AppColors.mainColor,),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: config.font20,
          ),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(config.radius30),
              borderSide: BorderSide(
                  width: 1,color: Colors.white
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(config.radius30),
              borderSide: BorderSide(
                  width: 1,color: Colors.white
              )
          ),
        ),
      ),
    );
  }
}

