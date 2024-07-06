import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/sign_page_containers.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/controller/CartController.dart';
import 'package:food_delivery/controller/order_controller.dart';
import 'package:food_delivery/controller/user_controller.dart';
import 'package:food_delivery/model/cart_model.dart';
import 'package:food_delivery/model/placeorder_model.dart';
import 'package:food_delivery/pages/address/address_page.dart';
import 'package:food_delivery/pages/cart/order_success.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:food_delivery/componants/config.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

enum paymentWays { cash, credit }

class _PlaceOrderState extends State<PlaceOrder> {



  paymentWays pw = paymentWays.cash;
  TextEditingController cardNo = TextEditingController();
  TextEditingController expired = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController note = TextEditingController();
  List<CartModel>? items;
  String address = "Apt. 861 5167 O'Keefe Row, North Moses, SC 91128";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: BigText(
          text: 'Place order',
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: config.height10,bottom: config.height10),
          child: GetBuilder<CartController>(
            builder: (cartController){
             items = cartController.getItems;
              return Column(
                children: [
                  //Address
                  Container(
                    height: 160,
                    margin: EdgeInsets.symmetric(horizontal: config.width20),
                    padding: EdgeInsets.symmetric(vertical: config.height20),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0, 5),
                          blurRadius: 3)
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.mainColor,
                              ),
                              SizedBox(
                                width: config.width10,
                              ),
                              BigText(
                                text: 'Address',
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: config.height10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: SmallText(
                            text: address,
                            size: config.font14,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: config.height10,
                        ),
                        Expanded(
                            child: Divider(
                              color: AppColors.paraColor,
                              thickness: 1,
                            )),
                        SizedBox(
                          height: config.height10,
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>AddressPage());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: config.width20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                  text: "Add another address",
                                  size: config.font14,
                                  color: Colors.black54,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.mainColor,
                                  size: config.iconSize16,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: config.height20,
                  ),
                  //payment way
                  Container(
                    height: config.pageViewTextContainer*1.75,
                    margin: EdgeInsets.symmetric(horizontal: config.width20),
                    padding: EdgeInsets.only(top: config.height20),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0, 5),
                          blurRadius: 3)
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: AppColors.mainColor,
                              ),
                              SizedBox(
                                width: config.width10,
                              ),
                              BigText(
                                text: 'Payment way',
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: config.height20,
                        ),
                        ListTile(
                          title: SmallText(
                            text: "Pay cash on delivery",
                            size: config.font14,
                            color: Colors.black54,
                          ),
                          leading: Radio<paymentWays>(
                            activeColor: AppColors.mainColor,
                            value: paymentWays.cash,
                            groupValue: pw,
                            onChanged: (paymentWays? value) {
                              setState(() {
                                pw = value!;
                                cartController.setPaymentWay('cash on delivery');
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: SmallText(
                            text: "Pay by credit card",
                            size: config.font14,
                            color: Colors.black54,
                          ),
                          leading: Radio<paymentWays>(
                            activeColor: AppColors.mainColor,
                            value: paymentWays.credit,
                            groupValue: pw,
                            onChanged: (paymentWays? value) {
                              setState(() {
                                pw = value!;
                                cartController.setPaymentWay('by credit card');
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw == paymentWays.credit?
                  SizedBox(
                    height: config.height20,
                  ):Container(),
                  //if pay with credit card
                  pw == paymentWays.credit?
                  Container(
                    height: config.pageViewTextContainer*2,
                    margin: EdgeInsets.symmetric(horizontal: config.width20),
                    padding: EdgeInsets.only(top: config.height20),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0, 5),
                          blurRadius: 3)
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.credit_card_rounded,
                                color: AppColors.mainColor,
                              ),
                              SizedBox(
                                width: config.width10,
                              ),
                              BigText(
                                text: 'Card info',
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: config.height20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: textFiled(cardNo, 'Card number'),
                        ),
                        SizedBox(
                          height: config.height10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: config.width45*3.5,
                                  child: textFiled(expired, 'MM/YY')),
                              Container(
                                  width: config.width45*3.5,
                                  child: textFiled(cvv, 'CVV')),
                            ],
                          ),
                        )
                      ],
                    ),
                  ):Container(),
                  SizedBox(
                    height: config.height20,
                  ),
                  //Add note
                  Container(
                    height: config.pageViewTextContainer*2,
                    margin: EdgeInsets.symmetric(horizontal: config.width20),
                    padding: EdgeInsets.only(top: config.height20),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0, 5),
                          blurRadius: 3)
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.receipt_rounded,
                                color: AppColors.mainColor,
                              ),
                              SizedBox(
                                width: config.width10,
                              ),
                              BigText(
                                text: 'Note',
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: config.height20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: TextFormField(
                            maxLines: 5,
                            controller: note,
                            decoration: InputDecoration(
                              hintText: 'Add note',
                              hintStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: config.font20,
                              ),
                              border: InputBorder.none
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: config.height20,
                  ),
                  //Details
                  Container(
                    height: config.pageViewTextContainer,
                    margin: EdgeInsets.symmetric(horizontal: config.width20),
                    padding: EdgeInsets.only(top: config.height20),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0, 5),
                          blurRadius: 3)
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.receipt_rounded,
                                color: AppColors.mainColor,
                              ),
                              SizedBox(
                                width: config.width10,
                              ),
                              BigText(
                                text: 'Details',
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: config.height20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.width20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(
                                text: "Total",
                                size: config.font18,
                                color: Colors.black54,
                              ),
                              SmallText(
                                text: '\$' + cartController.getItemsTotalPrice.toString(),
                                size: config.font18,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return GetBuilder<UserController>(builder: (userCon){
            return Container(
              height: 90,
              padding: EdgeInsets.symmetric(
                  horizontal: config.width20, vertical: config.height20),
              decoration: BoxDecoration(
                // color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(config.radius30),
                    topLeft: Radius.circular(config.radius30),
                  )),
              child: GestureDetector(
                onTap: () {
                  print(items);
                  PlaceOrderModel placeOrderModel = PlaceOrderModel(
                      cart: items,
                      orderAmount: cartController.getItemsTotalPrice.toDouble(),
                      orderNote: note.text,
                      distance: 45.0,
                      address: address,
                      latitude: '',
                      longitude: '',
                      contactPersonName: userCon.userModel!.name,
                      paymentMethod: pw == paymentWays.cash?'cash on delivery':'by credit card',
                      contactPersonNumber: userCon.userModel!.phone);

                  Get.find<OrderController>().PlaceOrder(placeOrderModel, callBack);
                  // cartController.addToPreviousList();
                  // Get.to(()=>OrderSuccessful());
                },
                child: Container(
                  width: config.width30 * 4,
                  padding: EdgeInsets.symmetric(
                      horizontal: config.width20, vertical: config.height15),
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(config.radius20)),
                  child: Center(
                    child: Text(
                      'Place order',
                      style:
                      TextStyle(fontSize: config.font18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  void callBack(bool isSuccess, String message, String orderID){
    if(isSuccess){
      print('order id -> $orderID, Message -> $message');
    }else{
      print('order id -> $orderID, Message -> $message');
    }
  }

  Widget textFiled(TextEditingController controller,String hintText){
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          color: Colors.black54,
          fontSize: config.font16,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(config.radius30/3),
            borderSide: BorderSide(
                width: 0.5,color: Colors.black54
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(config.radius30/3),
            borderSide: BorderSide(
                width: 0.5,color: Colors.grey
            )
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Get.find<UserController>().getUser();
  }
}
