import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/componants/icon_button.dart';
import 'package:food_delivery/controller/popular_product.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/pages/Home/HomePage.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import '../../componants/exandable_text_widget.dart';
import '../../controller/CartController.dart';
import '../../utils/app_constants.dart';

class PopularFoodDetails extends StatefulWidget {
  final ProductModel productModel;
  const PopularFoodDetails({super.key, required this.productModel});
  @override
  State<PopularFoodDetails> createState() => _PopularFoodDetailsState();
}

class _PopularFoodDetailsState extends State<PopularFoodDetails> {
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().initQuantuty(widget.productModel,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: config.foodDetailsImg - config.height45,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BaseUrl +
                    AppConstants.uploadImg +
                    widget.productModel.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: IconBtn(
                      iconData: Icons.clear,
                    )),
                GetBuilder<PopularProductController>(builder: (Pproduct){
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
            ),
            bottom: PreferredSize(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      top: config.height10 / 2, bottom: config.height10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(config.radius30),
                        topLeft: Radius.circular(config.radius30),
                      )),
                  child: Center(
                      child: BigText(
                    text: widget.productModel.name!,
                    color: Colors.black54,
                    size: config.font24,
                  )),
                ),
                preferredSize: Size.fromHeight(config.height20)),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: config.customScroll,
              padding: EdgeInsets.only(
                  right: config.width20,
                  left: config.width20,
                  top: config.height10),
              child: ExandableText(text: widget.productModel.description!),
            ),
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: config.width45 * 2,
                  right: config.width45 * 2,
                  top: config.height10,
                  bottom: config.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                      },
                      child: IconBtn(
                          iconData: Icons.remove,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white)),
                  BigText(
                    text: "\$${widget.productModel.price}" + " * " + "${controller.cartItems}",
                    color: Colors.black87,
                    size: config.font24,
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                      child: IconBtn(
                          iconData: Icons.add,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white)),
                ],
              ),
            ),
            Container(
              height: 90,
              padding: EdgeInsets.symmetric(
                  horizontal: config.width20, vertical: config.height20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(config.radius30),
                    topLeft: Radius.circular(config.radius30),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: config.width20, vertical: config.height15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(config.radius30)),
                    child: Icon(Icons.favorite_outline_rounded,
                        color: AppColors.mainColor),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItems(widget.productModel);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: config.width20, vertical: config.height15),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(config.radius20)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${widget.productModel.price} | Add to card',
                            style: TextStyle(
                                fontSize: config.font16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
