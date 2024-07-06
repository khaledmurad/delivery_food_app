import 'package:flutter/material.dart';
import 'package:food_delivery/controller/auth_controller.dart';
import 'package:food_delivery/controller/order_controller.dart';
import 'package:food_delivery/controller/popular_product.dart';
import 'package:food_delivery/controller/recommended.product.dart';
import 'package:food_delivery/controller/user_controller.dart';
import 'package:food_delivery/pages/Home/HomePage.dart';
import 'package:food_delivery/pages/Home/main_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food_details/food_details.dart';
import 'package:food_delivery/pages/food_details/popular_food_details.dart';
import 'package:food_delivery/pages/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'controller/CartController.dart';
import 'controller/address_controller.dart';
import 'model/dependencies.dart' as dependencies;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getcartItemsList();
    Get.find<PopularProductController>().getPopularProducts();
    Get.find<RecommendedProductController>().getRecommendedProducts();
    Get.find<CartController>();
    Get.find<OrderController>();
    Get.find<AddressController>();
    Get.find<AuthController>();
    Get.find<UserController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
