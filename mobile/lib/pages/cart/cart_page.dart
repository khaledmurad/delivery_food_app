import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/componants/icon_button.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/controller/CartController.dart';
import 'package:food_delivery/controller/popular_product.dart';
import 'package:food_delivery/model/cart_model.dart';
import 'package:food_delivery/pages/Home/HomePage.dart';
import 'package:food_delivery/pages/Home/main_page.dart';
import 'package:food_delivery/pages/cart/place_order.dart';
import 'package:food_delivery/pages/food_details/food_details.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<CartController>(
          builder:(cartController){
            List<CartModel> items = cartController.getItems;
        return Stack(
          children: [
            Positioned(
                top: config.height20*3,
                right: config.width20,
                left: config.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                        child: BigText(text: cartController.getItemsQuantity().toString(),color: Colors.white,
                          size: config.font20,),
                      ),
                    ),
                  ],
                )),
            (cartController.items.isNotEmpty)?
            Positioned(
                top: config.height20*5.1,
                left: config.width20,
                right: config.width20,
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.only(bottom: config.height10),
                          height: config.height20*5,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(config.radius20)
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=> FoodDetails(popularProduct: items[index].product!,));
                                },
                                child: Container(
                                  height: config.height20*5,
                                  width: config.height20*5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(config.radius20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                      AppConstants.BaseUrl + AppConstants.uploadImg + items[index].img!),
                                          fit: BoxFit.cover)
                                  ),
                                ),
                              ),
                              SizedBox(width: config.width10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(text: items[index].name!,color: Colors.black54,size: config.font18,),
                                  SmallText(text: 'Enjoy your meal',),
                                  Container(
                                    width: config.height30*8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        BigText(text: '\$${items[index].price}',color: AppColors.yellowColor),
                                        // SizedBox(width: config.width45*2.5,),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: config.width10,vertical: config.height10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(config.radius20)
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                  onTap: (){
                                                    cartController.addItem(items[index].product!, -1);
                                                  },
                                                  child: Icon(Icons.remove,color: AppColors.signColor)),
                                              SizedBox(width: config.width10),
                                              Text(items[index].quantity.toString(),style: TextStyle(fontSize: config.font16),),
                                              SizedBox(width: config.width10),
                                              GestureDetector(
                                                  onTap: (){
                                                    cartController.addItem(items[index].product!, 1);
                                                  },
                                                  child: Icon(Icons.add,color: AppColors.signColor,)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                )):
                Center(
                  child: Container(
                    height: config.pageView,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: config.height45*2,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/images/emptycard1.png'))
                          ),
                        ),
                        SizedBox(height: config.height10,),
                        SmallText(text: 'Cart is empty',color: Colors.black54,size: config.font20,)
                      ],
                    ),
                  ),
                )
          ],
        );
      }),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController){
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
                  width: config.width30*4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(config.radius20)
                  ),
                  child: Center(
                    child: BigText(text: '\$' + cartController.getItemsTotalPrice.toString(),color: AppColors.mainBlackColor,
                    size: config.font18,),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    // cartController.addToPreviousList();
                    Get.to(()=>PlaceOrder());
                  },
                  child: Container(
                    width: config.width30*4,
                    padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height15),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor ,
                        borderRadius: BorderRadius.circular(config.radius20)
                    ),
                    child: Center(
                      child: Text('Checkout',
                        style: TextStyle(
                            fontSize: config.font16,color: Colors.white),),
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
