import 'package:food_delivery/controller/depo.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';

class CartController extends GetxController{

  final Depo depo;
  Map<int, CartModel> items={};
  String paymentWay = '';
  CartController({required this.depo});

  List<CartModel> cartModelItemList = [];

  void addItem(ProductModel product, int quantity){
    int? AllQuantity;
    if(items.containsKey(product.id)){
      items.update(product.id!, (value){
        AllQuantity = value.quantity! + quantity;
        return CartModel(
            id : product.id,
            name : product.name,
            price : product.price,
            img : product.img,
            quantity : value.quantity! + quantity,
            time : DateTime.now().toString(),
            isExist : true,
            product: product
        );
      });
      if(AllQuantity == 0){
        items.remove(product.id);
      }
    }else{
      if(quantity>0){
        items.putIfAbsent(product.id!, (){
          return CartModel(
              id : product.id,
              name : product.name,
              price : product.price,
              img : product.img,
              quantity : quantity,
              time : DateTime.now().toString(),
              isExist : true,
              product: product
          );});
      }
    }
    
    depo.addToCartList(getItems);
    update();
  }

  bool ifExist(ProductModel productModel){
    if(items.containsKey(productModel.id)){
      return true;
    }else{
      return false;
    }
  }

  int getQuantity(ProductModel productModel){
    int quantity = 0;
    if(items.containsKey(productModel.id)){
      items.forEach((key, value) {
        print(value.quantity);
        if(productModel.id == value.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;

  }

  int getItemsQuantity(){
    int itemQuanitiy = 0;
    items.forEach((key, value) {
      itemQuanitiy += value.quantity!;
    });
    return itemQuanitiy;
  }

  List<CartModel> get getItems{
    return items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get getItemsTotalPrice{
    int totalPrice =0;
    items.forEach((key, value) {
      totalPrice += value.price! * value.quantity!;
    });
    return totalPrice;
  }

  List<CartModel> getcartItemsList(){
    setCartList = depo.getCartModel();
    return cartModelItemList;
  }

  set setCartList(List<CartModel> itemList){
    cartModelItemList = itemList;
    print('Length items in cart ${cartModelItemList.length}');
    for(int i =0;i<cartModelItemList.length;i++){
      items.putIfAbsent(cartModelItemList[i].product!.id!, () => cartModelItemList[i]);
    }
  }

  void addToPreviousList(){
    depo.addToPreviousList();
    clearItems();
  }

  void clearItems(){
    items = {};
    update();
  }

  List<CartModel> getCartPreviousItemsList(){
    // setCartList = depo.getCartPreviousModel();
    return depo.getCartPreviousModel();
  }

  set setItemsOrderAgain(Map<int, CartModel> itemsOrder){
    items = {};
    items= itemsOrder;
  }

  void addToCartList(){
    depo.addToCartList(getItems);
    update();
  }
  void setPaymentWay(pw){
    paymentWay = pw;
  }
}