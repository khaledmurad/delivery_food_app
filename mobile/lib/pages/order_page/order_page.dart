import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/controller/order_controller.dart';
import 'package:food_delivery/pages/order_page/view_tab.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{

  TabController? _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Get.find<OrderController>().getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: BigText(text: 'My orders',color: Colors.white,)),
      backgroundColor: AppColors.mainColor,elevation: 0,),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
              labelColor: AppColors.mainColor,
              indicatorColor:AppColors.mainColor,
              tabs: [
                Tab(child: Text( 'Currant',style: TextStyle(fontSize:config.font18 ),),),
                Tab(child: Text( 'History',style: TextStyle(fontSize:config.font18 )),),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  ViewTab(isCurrant: true,),
                  ViewTab(isCurrant: false,),
                ]),
          )
        ],
      ),
    );
  }
}
