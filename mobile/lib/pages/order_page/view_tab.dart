import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/controller/order_controller.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/model/oder_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';


class ViewTab extends StatelessWidget {
  bool isCurrant;
  ViewTab({super.key, required this.isCurrant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(
        builder: (orderController){
          if(orderController.isLoading == false){
            List<OrderModel>? orderList;
            if(orderController.currantOrderList!.isNotEmpty){
              orderList = isCurrant ? orderController.currantOrderList!.reversed.toList():
                  orderController.historyOrderList!.reversed.toList();
            }
            return SizedBox(
              width: double.infinity,
              child: orderList!.isNotEmpty?
              ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index){
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: config.width10,
                        left: config.width10,
                        bottom: config.height10,
                        top: config.height10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order id  #"+orderList![index].id.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(config.width10/2),
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(config.radius20/4)
                                ),
                                child: Text(orderList[index].orderStatus!,style: TextStyle(color: Colors.white),),
                              ),
                              SizedBox(height: config.height10/2,),
                              Container(
                                padding: EdgeInsets.all(config.width10/2),
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.mainColor,width: 1),
                                    borderRadius: BorderRadius.circular(config.radius20/4)
                                ),
                                child: Text("Track order",),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey[300],height: 1,)
                  ],
                );
              })
              :Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: config.height45*2,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/makeorder.png'))
                      ),
                    ),
                    SizedBox(height: config.height20,),
                    BigText(text: 'No orders, Make new one',color: Colors.black,size: config.font18,)
                  ],
                ),
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
