import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/column_details.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/componants/exandable_text_widget.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/controller/CartController.dart';
import 'package:food_delivery/controller/popular_product.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/pages/Home/HomePage.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../../componants/icon_button.dart';
import '../../utils/app_constants.dart';

class FoodDetails extends StatelessWidget {
  final ProductModel popularProduct;
  FoodDetails({super.key, required this.popularProduct});
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().initQuantuty(popularProduct,Get.find<CartController>());
    return Scaffold(
      body: Container(
        height: config.screenHeight,
        child: Stack(
          children: [
            Positioned(
                child: Container(
                  height: config.foodDetailsImg,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            AppConstants.BaseUrl + AppConstants.uploadImg + popularProduct.img!),
                    )
                  ),
                )),
            Positioned(
                top: config.height45,
                left: config.width20,
                right: config.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: IconBtn(iconData: Icons.arrow_back_ios_new_outlined,)),

                    GetBuilder<PopularProductController>(builder: (Pproduct){
                      Get.find<CartController>();
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=>HomePage(pageInt: 2,));
                        },
                        child: Stack(
                            children: [
                              IconBtn(iconData: Icons.shopping_cart_outlined,),
                              // Positioned(
                              //     top: 4,right: 5,
                              //     child: (Pproduct.itemsQuantity()>=1)?IconBtn(iconData: Icons.circle,size: 17,backgroundColor: AppColors.mainColor,
                              //     iconColor: AppColors.mainColor,):Container()),
                              // Positioned(
                              //     top: 5,right: 6,
                              //     child: (Pproduct.itemsQuantity()>=1)?
                              //     BigText(text: Pproduct.itemsQuantity().toString(),color: Colors.white,
                              //     size: config.font14,)
                              //         :Container()),
                              Positioned(
                                  top: 4,right: 5,
                                  child: (Pproduct.itemsQuantity()>=1)?
                                  Container(
                                     height: config.height30/1.75,
                                    width: config.height30/1.75,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.mainColor,
                                    ),
                                    child: Center(
                                      child: BigText(text: Pproduct.itemsQuantity().toString(),color: Colors.white,
                                        size: config.font14,),
                                    ),
                                  )
                                      :Container()),
                            ],
                        ),
                      );
                    })
                  ],
                )),
            Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top:  config.foodDetailsImg - config.height20,
                child: Container(
                  padding: EdgeInsets.only(right: config.width20,left: config.width20,top: config.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(config.radius20),
                      topLeft: Radius.circular(config.radius20),
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColumnDetails(text: popularProduct.name!,textSize: config.font26,stars: popularProduct.stars!),
                      SizedBox(height: config.height20),
                      BigText(text: 'Introduce',color: Colors.black87,),
                      SizedBox(height: config.height10),
                      Expanded(
                        child: SingleChildScrollView(
                            child: ExandableText(text: popularProduct.description!,)),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (product){
          return Container(
            height: 90,
            padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(config.radius30),
                  topLeft: Radius.circular(config.radius30),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(config.radius20)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                            product.setQuantity(false);
                          },
                          child: Icon(Icons.remove,color: AppColors.signColor)),
                      SizedBox(width: config.width10),
                      Text(product.cartItems.toString(),style: TextStyle(fontSize: config.font16),),
                      SizedBox(width: config.width10),
                      GestureDetector(
                          onTap: (){
                            product.setQuantity(true);
                          },
                          child: Icon(Icons.add,color: AppColors.signColor,)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                      product.addItems(popularProduct);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height15),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor ,
                        borderRadius: BorderRadius.circular(config.radius20)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('\$${popularProduct.price} | Add to card',
                          style: TextStyle(
                              fontSize: config.font16,color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
