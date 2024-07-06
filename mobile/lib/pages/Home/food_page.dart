import 'package:flutter/material.dart';
import 'package:food_delivery/componants/column_details.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/icon_and_text.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/controller/popular_product.dart';
import 'package:food_delivery/controller/recommended.product.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/pages/food_details/food_details.dart';
import 'package:food_delivery/pages/food_details/popular_food_details.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  PageController _pageController = PageController(viewportFraction: 0.85);
  var currentpage = 0.0;
  double scaleFactor = 0.8;
  double _height = config.pageViewContainer;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentpage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //page view list
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return (popularProduct.isLoading)
              ? Container(
                  height: config.pageView,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: popularProduct.popularProducts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.to(()=> FoodDetails(popularProduct: popularProduct.popularProducts[index],));
                          },
                          child: _buildFoodPage(
                              index, popularProduct.popularProducts[index]),
                        );
                      }),
                )
              : Container(
                  height: config.pageView,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  )));
        }),

        //dots
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularProducts.isEmpty
                ? 1
                : popularProduct.popularProducts.length,
            position: currentpage.toInt(),
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(8.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        // popular text
        config.screensmall,
        Container(
          padding: EdgeInsets.symmetric(horizontal: config.width15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: "Recommended",
                color: Colors.black54,
              ),
              SizedBox(
                width: config.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: config.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              ),
            ],
          ),
        ),

        //listview
        GetBuilder<RecommendedProductController>(builder: (recoProduct) {
          return (recoProduct.isLoading)
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recoProduct.recommendedProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>PopularFoodDetails(productModel: recoProduct.recommendedProducts[index],));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: config.width15),
                        margin: EdgeInsets.only(bottom: config.height10),
                        height: config.listViewImgSize,
                        child: Row(
                          children: [
                            Container(
                              height: config.listViewImgSize,
                              width: config.listViewImgSize,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(config.radius20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          AppConstants.BaseUrl + AppConstants.uploadImg + recoProduct.recommendedProducts[index].img),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Container(
                                height: config.listViewTextContainerSize,
                                padding: EdgeInsets.only(
                                    left: config.width10, right: config.width10),
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                            Radius.circular(config.radius20),
                                        bottomRight:
                                            Radius.circular(config.radius20))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: recoProduct.recommendedProducts[index].name,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(
                                      height: config.height10,
                                    ),
                                    Text(
                                      recoProduct.recommendedProducts[index].description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFFccc7c5),
                                        fontFamily: 'poppins',
                                      ),
                                    ),
                                    // SmallText(
                                    //   text: recoProduct.recommendedProducts[index].description,
                                    // ),
                                    SizedBox(
                                      height: config.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndText(
                                            icon: Icons.circle,
                                            text: "Normal",
                                            iconColor: AppColors.iconColor2),
                                        IconAndText(
                                            icon: Icons.location_on_rounded,
                                            text: "1 KM",
                                            iconColor: AppColors.mainColor),
                                        IconAndText(
                                            icon: Icons.access_time_rounded,
                                            text: "40 min",
                                            iconColor: Colors.redAccent),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Container(
                  height: 0);
        })
      ],
    );
  }

  Widget _buildFoodPage(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = new Matrix4.identity();
    if (index == currentpage.floor()) {
      var currScale = 1 - (currentpage - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentpage.floor() + 1) {
      var currScale =
          scaleFactor + (currentpage - index + 1) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentpage.floor() - 1) {
      var currScale = 1 - (currentpage - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          Container(
            height: config.pageViewContainer,
            margin: EdgeInsets.symmetric(horizontal: config.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(config.radius15),
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      AppConstants.BaseUrl + AppConstants.uploadImg + popularProduct.img!),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: config.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: config.width30,
                  right: config.width30,
                  bottom: config.height25),
              // padding: EdgeInsets.only(right: 30,left: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(config.radius15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.textColor,
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ]),
              child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: config.width10, vertical: config.height10),
                  child: ColumnDetails(
                    text: popularProduct.name!,stars: popularProduct.stars!,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
