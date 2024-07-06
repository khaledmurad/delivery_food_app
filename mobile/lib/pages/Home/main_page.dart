import 'package:flutter/material.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/utils/colors.dart';
import 'food_page.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: config.height45),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: config.width15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(text: "Türkiye"),
                      Row(
                        children: [
                          SmallText(text: "Istanbul",color: Colors.black54,),
                          Icon(Icons.arrow_drop_down_rounded,size: 20,)
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: config.width45 ,height: config.height45,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(config.radius15)
                    ),
                    child: Icon(Icons.search_rounded,color: Colors.white,size: config.iconSize24,),
                  )
                ],
              ),
            ),
            config.screensmall,
            Expanded(
              child: SingleChildScrollView(
                  child: FoodPage()),
            )
          ],
        ),
      ),
    );
  }
}
