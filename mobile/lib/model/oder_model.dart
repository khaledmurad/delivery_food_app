import 'package:food_delivery/model/address_model.dart';

class OrderModel{
  int? userId;
  int? id;
  double? orderAmount;
  String? orderStatus;
  String? paymentStatus;
  String? orderNote;
  String? createdId;
  String? updatedId;
  String? scheduleAt;
  String? otp;
  double? totalTaxAmount;
  double? deliveryCharge;
  String? pending;
  String? accepted;
  String? confirmed;
  String? processing;
  String? handover;
  String? pickedUp;
  String? delivered;
  String? canceled;
  String? refundRequested;
  String? refunded;
  String? failed;
  int? scheduled;
  int? detailsCount;
  AddressModel? addressModel;

  OrderModel({
    required this.id,required this.userId,
    this.orderAmount,
    this.orderStatus,
    this.paymentStatus,
    this.orderNote,
    this.createdId,
    this.updatedId,
    this.scheduleAt,
    this.otp,
    this.totalTaxAmount,
    this.deliveryCharge,
    this.pending,
    this.accepted,
    this.confirmed,
    this.processing,
    this.handover,
    this.pickedUp,
    this.delivered,
    this.canceled,
    this.refundRequested,
    this.refunded,
    this.failed,
    this.detailsCount ,
    this.scheduled ,
    this.addressModel
});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['order_amount'].toDouble();
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status']??'pending';
    orderNote = json['order_note'];
    createdId = json['created_id'];
    updatedId = json['updated_id'];
    scheduleAt = json['schedule_at']?? '';
    otp = json['opt'];
    totalTaxAmount = 10.0;
    deliveryCharge = 10.0;
    pending = json['pending']??"";
    accepted = json['accepted']??"";
    confirmed = json['confirmed']??"";
    processing = json['processing']??"";
    handover = json['handover']??"";
    pickedUp = json['picked_up']??"";
    delivered = json['delivered']??"";
    canceled = json['canceled']??"";
    refundRequested = json['refund_requested']??"";
    refunded = json['refunded']??"";
    failed = json['failed']??"";
    detailsCount = json['details_count'];
    scheduled = json['scheduled'];
    addressModel = json['delivery_address'] != null?
        new AddressModel.fromJson(json['delivery_address']):
        null;
  }

  Map<String, dynamic> toJson(){
    String? x;
    if(this.addressModel != null){
       x = this.addressModel.toString();
    }
    return{
      'id' : this.id,
      'user_id' : this.userId,
      'order_amount' : this.orderAmount,
      'order_status' : this.orderStatus,
      'payment_status' : this.paymentStatus,
      'otp' : this.otp,
      'order_note' : this.orderNote,
      'created_id' : this.createdId,
      'updated_id' : this.updatedId,
      'schedule_at' : this.scheduleAt,
      'total_tax_amount' : this.totalTaxAmount,
      'delivery_charge' : this.deliveryCharge,
      'pending' : this.pending,
      'accepted' : this.accepted,
      'confirmed' : this.confirmed,
      'processing' : this.processing,
      'handover' : this.handover,
      'picked_up' : this.pickedUp,
      'delivered' : this.delivered,
      'canceled' : this.canceled,
      'refund_requested' : this.refundRequested,
      'refunded' : this.refunded,
      'failed' : this.failed,
      'details_count' : this.detailsCount,
      'scheduled' : this.scheduled,
      'delivery_address' : x!
    };
  }
}