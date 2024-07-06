import 'package:food_delivery/model/cart_model.dart';

class PlaceOrderModel{
  List<CartModel>? cart;
  double? orderAmount;
  String? orderNote;
  double? distance;
  String? address;
  String? latitude;
  String? longitude;
  String? contactPersonName;
  String? contactPersonNumber;
  String? paymentMethod;

  PlaceOrderModel(
      {
      required this.cart,
      required this.orderAmount,
      required this.orderNote,
      required this.distance,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.contactPersonName,
      required this.paymentMethod,
      required this.contactPersonNumber
      });

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    if(json['cart'] != null){
        cart = [];
        json['cart'].forEach((v){
          cart!.add(CartModel.fromJson(v));
        });
    }
    orderAmount = json['order_amount'];
    orderNote = json['order_note'];
    distance = json['distance'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson(){
    var j;
    if(this.cart != null){
      j = this.cart!.map((e) => e.toJson()).toList();
    }
    return{
      'cart' : j,
      'order_amount' : this.orderAmount,
      'order_note' : this.orderNote,
      'distance' : this.distance,
      'address' : this.address,
      'longitude' : this.longitude,
      'latitude' : this.latitude,
      'contact_person_name' : this.contactPersonName,
      'contact_person_number' : this.contactPersonNumber,
      'payment_method' : this.paymentMethod,
    };
  }
}