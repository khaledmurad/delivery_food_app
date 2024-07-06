import 'package:food_delivery/controller/apiclint.dart';
import 'package:food_delivery/model/oder_model.dart';
import 'package:food_delivery/model/placeorder_model.dart';
import 'package:food_delivery/pages/cart/place_order.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService{
  final ApiClient apiClient;
  OrderController({required this.apiClient});
  List<OrderModel>? currantOrderList;
  List<OrderModel>? historyOrderList;
  bool isLoading = false;
  Future<void> PlaceOrder(PlaceOrderModel placeOrderModel, Function callback) async{
    isLoading = true;
    Response response = await apiClient.postData(AppConstants.PlaceOrderURI, placeOrderModel);
    if(response.statusCode == 200){
      isLoading = false;

      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();

      callback(true,message,orderID);
    }else{
      callback(false, response.statusText , '-1');
    }
  }

  Future getOrderList() async{
    isLoading = true;
    Response response = await apiClient.getData(AppConstants.GetOrderURI);

    if(response.statusCode == 200){
      currantOrderList = [];
      historyOrderList = [];
      response.body.forEach((order){
        OrderModel orderModel = OrderModel.fromJson(order);
        if(orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up'){
          currantOrderList!.add(orderModel);
        }else{
          historyOrderList!.add(orderModel);
        }
      });
    }else{
      currantOrderList = [];
      historyOrderList = [];
    }
    isLoading = false;
    print('lenght of orders is ${currantOrderList!.length.toString()}');
    update();
  }
}