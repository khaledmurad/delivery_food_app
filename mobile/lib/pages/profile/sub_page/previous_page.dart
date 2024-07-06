import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/controller/CartController.dart';
import 'package:food_delivery/model/cart_model.dart';
import 'package:food_delivery/pages/Home/HomePage.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:food_delivery/componants/config.dart';

class PreviousCartPage extends StatelessWidget {
  const PreviousCartPage({super.key});

  @override
  Widget build(BuildContext context) {

    var getItemPreviousList = Get.find<CartController>().getCartPreviousItemsList().reversed.toList();
    Map<String, int> cartItemPerOrder = Map();

    for(int i =0; i<getItemPreviousList.length;i++){
      if(cartItemPerOrder.containsKey(getItemPreviousList[i].time)){
        cartItemPerOrder.update(getItemPreviousList[i].time!, (value) => ++value);
      }else{
        cartItemPerOrder.putIfAbsent(getItemPreviousList[i].time!, ()=> 1);
      }
    }

    List<int> cartOrderItemToList(){
      return cartItemPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemPerOrder.entries.map((e) => e.key).toList();
    }
    List<int> cartOITL = cartOrderItemToList();

    int listCounter = 0;

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: Text('Previous orders',style: TextStyle(
              color: Colors.white
          )),
        ),
      ),
      body: Container(

        margin: EdgeInsets.only(top: config.height20,left: config.width20,right: config.width20),
        child: ListView(
          children: [
            for(int i = 0; i<cartOrderItemToList().length; i++)
              Container(
                margin: EdgeInsets.only(bottom: config.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BigText(text: getItemPreviousList[listCounter].time!,color: Colors.black54,size: config.font16,),
                      SizedBox(height: config.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            children: List.generate(cartOrderItemToList()[i], (index)
                            {
                              if(listCounter < getItemPreviousList.length){
                                listCounter++;
                              }
                              return index<=2?Container(
                                margin: EdgeInsets.only(right: config.width10/2),
                                height: config.height20 * 4,
                                width: config.height20 * 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(config.radius20/2),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                    AppConstants.BaseUrl+AppConstants.uploadImg+getItemPreviousList[listCounter-1].img!
                                  ))
                                ),
                              ):Container();
                            }),
                          ),
                          Container(
                            height: config.height20*4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SmallText(text: 'Total',color: Colors.black54,),
                                BigText(text: (cartOrderItemToList()[i]>1)?"${cartOrderItemToList()[i]} Items":"${cartOrderItemToList()[i]} Item",color: Colors.black54,size: config.font16,),
                                GestureDetector(
                                  onTap: (){
                                    Map<int, CartModel> orderAgain = {};
                                    for(int x=0; x<getItemPreviousList.length;x++){
                                      if(getItemPreviousList[x].time == cartOrderTimeToList()[i]){
                                        orderAgain.putIfAbsent(getItemPreviousList[x].id!, () => 
                                        CartModel.fromJson(jsonDecode(jsonEncode(getItemPreviousList[x]))));
                                      }
                                    }

                                    Get.find<CartController>().setItemsOrderAgain = orderAgain;
                                    Get.find<CartController>().addToCartList();
                                    Get.to(()=>HomePage(pageInt: 2,));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(config.radius15/2),
                                      border: Border.all(
                                        color: AppColors.mainColor,width: 1,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: config.height10/2,horizontal: config.width10),
                                    child: Center(child: SmallText(text: 'Order again',color: AppColors.mainColor,size: 12),),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  ],
                ),
              )

          ],
        ),
      ),
    );
  }
}
