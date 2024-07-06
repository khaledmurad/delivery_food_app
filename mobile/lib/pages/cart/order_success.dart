import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/pages/Home/HomePage.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';


class OrderSuccessful extends StatelessWidget {
  const OrderSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: config.height45*2.5,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/success.png'))
            ),
          ),
          SizedBox(height: config.height20,),
          BigText(text: 'You placed the order successfully',color: Colors.black54,),
          SizedBox(height: config.height45,),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(pageInt: 0,)));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height10),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(config.radius20/3)
              ),
              child: BigText(text: 'Back to home page',color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }
}
