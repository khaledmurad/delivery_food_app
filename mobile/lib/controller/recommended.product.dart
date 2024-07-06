import 'package:food_delivery/controller/apiclint.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController{

  final ApiClient apiClient;

  RecommendedProductController({required this.apiClient});

  bool isLoading = false;
  List<dynamic> recommendedProducts =[];

  Future getRecommendedProducts() async{
    var response = await apiClient.getData(AppConstants.RecommendedProductsURI);
    if(response.statusCode == 200){
      recommendedProducts = [];
      recommendedProducts.addAll(Product.fromJson(response.body).products);
      print('Recommended products got');
      isLoading = true;
      update();
    }else{
      print(response.statusText);
      print('didn\'t get products');
    }
  }


}