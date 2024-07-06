import 'package:food_delivery/controller/CartController.dart';
import 'package:food_delivery/controller/apiclint.dart';
import 'package:food_delivery/model/cart_model.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{

  final ApiClient apiClient;

  PopularProductController({required this.apiClient});

  bool isLoading = false;
  List<dynamic> popularProducts =[];
  late CartController cart;
  int quantity = 0;
  int qCartItems = 0;
  int get cartItems => qCartItems + quantity;

  Future getPopularProducts() async{
    var response = await apiClient.getData(AppConstants.PopularProductsURI);
    if(response.statusCode == 200){
      popularProducts = [];
      popularProducts.addAll(Product.fromJson(response.body).products);
      print('products got');
      isLoading = true;
      update();
    }else{
      print(response.statusText);
      print('didn\'t get products');
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      quantity = checkQuantity(quantity+1);
    }else if(qCartItems+quantity>0){
      quantity = checkQuantity(quantity-1);
    }
    update();
  }
  int checkQuantity(int q){
    if(qCartItems+q<0){
      return 0;
    }else{
      return q;
    }
  }
  void initQuantuty(ProductModel product,CartController cartController){
    quantity = 0;
    qCartItems = 0;
    cart=cartController;
    var ifExist = false;
    ifExist = cart.ifExist(product);
    if(ifExist){
       qCartItems= cart.getQuantity(product);
    }

  }

  void addItems(ProductModel productModel){
      cart.addItem(productModel, quantity);
      quantity = 0;
      qCartItems= cart.getQuantity(productModel);

      cart.items.forEach((key, value) {
        print("Item id " + value.name! + " quantity value = "+ value.quantity.toString());
      });
      update();
  }

  int itemsQuantity(){
    return cart.getItemsQuantity();

  }

  List<CartModel> get getItems{
    return cart.getItems;
  }
}