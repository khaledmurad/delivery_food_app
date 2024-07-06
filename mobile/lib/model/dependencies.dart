import 'package:food_delivery/controller/CartController.dart';
import 'package:food_delivery/controller/address_controller.dart';
import 'package:food_delivery/controller/apiclint.dart';
import 'package:food_delivery/controller/auth_controller.dart';
import 'package:food_delivery/controller/depo.dart';
import 'package:food_delivery/controller/order_controller.dart';
import 'package:food_delivery/controller/popular_product.dart';
import 'package:food_delivery/controller/recommended.product.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/user_controller.dart';

Future<void> init()async{
  SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BaseUrl,sharedPreferences: sharedPreferences));

  Get.lazyPut(() => PopularProductController(apiClient: Get.find()));

  Get.lazyPut(() => CartController(depo: Get.find()));

  Get.lazyPut(() => AddressController(Get.find(), sharedPreferences));

  Get.lazyPut(() => OrderController(apiClient: Get.find()));

  Get.lazyPut(() => RecommendedProductController(apiClient: Get.find()));

  Get.lazyPut(() => AuthController(apiClient: Get.find(),sharedPreferences: sharedPreferences));

  Get.lazyPut(() => UserController(apiClient: Get.find(),sharedPreferences: sharedPreferences));

  Get.lazyPut(() => Depo(sharedPreferences: sharedPreferences) );
}