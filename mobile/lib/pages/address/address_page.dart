import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/componants/sign_page_containers.dart';
import 'package:food_delivery/controller/address_controller.dart';
import 'package:food_delivery/controller/user_controller.dart';
import 'package:food_delivery/model/address_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../componants/snack_bar.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  TextEditingController addressController = TextEditingController();
  TextEditingController contactPersonName = TextEditingController();
  TextEditingController contactPhoneNo = TextEditingController();
  late bool isLoading;
  CameraPosition cameraPosition = const CameraPosition(target: LatLng(40.431900, 29.155423));
  late LatLng latLng = LatLng(40.431900, 29.155423);


  @override
  void initState() {
    super.initState();
    if(Get.find<AddressController>().addressList.isNotEmpty ){
      Get.find<AddressController>().getUserAddress();
      cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<AddressController>().getAddress!['latitude']),
        double.parse(Get.find<AddressController>().getAddress!['longitude']),
      ));

      latLng = LatLng(
        double.parse(Get.find<AddressController>().getAddress!['latitude']),
        double.parse(Get.find<AddressController>().getAddress!['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: Text('Address',style: TextStyle(
            color: Colors.white
        )),
      ),
      body: GetBuilder<UserController>(builder: (userController){
          if(userController.userModel!=null && contactPersonName.text.isEmpty){
            contactPersonName.text = userController.userModel!.name!;
            contactPhoneNo.text = userController.userModel!.phone!;
            if(Get.find<AddressController>().addressList.isNotEmpty){
              addressController.text = Get.find<AddressController>().getUserAddress().address!;
            }
          }
        return GetBuilder<AddressController>(builder: (aController){
          addressController.text = '${aController.placemark.name??''}'
              '${aController.placemark.locality??''}'
              '${aController.placemark.postalCode??''}'
              '${aController.placemark.country??''}';
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: config.height30 * 5,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: config.width20,left: config.width20,top: config.height20),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(config.radius20/2),
                      border: Border.all(
                          width: 2,color: AppColors.mainColor
                      )
                  ),
                  child: GoogleMap(initialCameraPosition: CameraPosition(target: latLng,zoom: 17),
                    compassEnabled: false,
                    indoorViewEnabled: true,zoomControlsEnabled: false,mapToolbarEnabled: false,
                    myLocationEnabled: true,
                    onCameraMove: ((position) => cameraPosition = position),
                    onMapCreated: ((GoogleMapController googleController){
                      aController.setGoogleMapController(googleController);
                    }),
                    onCameraIdle: (){
                      aController.updateAddress(cameraPosition , true);
                    },),
                ),
                SizedBox(height: config.height30,),
                Container(height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: aController.addressTypeList.length,
                    itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      setState((){
                        aController.setAddressTypeIndex(index);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height10),
                      margin: EdgeInsets.only(left: config.width20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(config.radius20 /2),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300,
                              offset: Offset(5, 5),
                              blurRadius: 4)
                        ]
                      ),
                      child: Center(
                        child: Icon(index == 0? Icons.home_filled:index==1?Icons.work_rounded:Icons.location_on_rounded,
                        color: aController.addressTypeListIndex == index?AppColors.mainColor:AppColors.iconColor2,),
                      ),
                    ),
                  );
                }),),
                SizedBox(height: config.height20,),
                Padding(
                  padding: EdgeInsets.only(left: config.width20),
                  child: BigText(text: 'Your address',color: Colors.black54,),
                ),
                SizedBox(height: config.height10,),
                SignPageContainers(controller: addressController,hintText: 'Address',iconData: Icons.map,),
                SizedBox(height: config.height20,),
                Padding(
                  padding: EdgeInsets.only(left: config.width20),
                  child: BigText(text: 'Contact name',color: Colors.black54,),
                ),
                SizedBox(height: config.height10,),
                SignPageContainers(controller: contactPersonName,hintText: 'Name',iconData: Icons.person,),
                SizedBox(height: config.height20,),
                Padding(
                  padding: EdgeInsets.only(left: config.width20),
                  child: BigText(text: 'Contact Phone no.',color: Colors.black54,),
                ),
                SizedBox(height: config.height10,),
                SignPageContainers(controller: contactPhoneNo,hintText: 'Phone no.',iconData: Icons.phone_android_rounded,),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<AddressController>(
        builder: (address){
          return Container(
            height: 90,
            padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(config.radius30),
                  topLeft: Radius.circular(config.radius30),
                )
            ),
            child: GestureDetector(
              onTap: () async {
                AddressModel addressModel = AddressModel(
                  addressType: address.addressTypeList[address.addressTypeListIndex],
                  address: addressController.text,
                  contactPhoneNo: contactPhoneNo.text,
                  contactPersonName: contactPersonName.text,
                  latitude: address.position.latitude.toString(),
                  longitude: address.position.longitude.toString(),
                );

                final response = await address.addNewAddress(addressModel);
                if(response){
                  getSnackBar('Address added successfully',isError: false,title: 'New address');
                }else{
                  getSnackBar('Couldn\'t add address',isError: true,title: 'Error');
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height15),
                decoration: BoxDecoration(
                    color: AppColors.mainColor ,
                    borderRadius: BorderRadius.circular(config.radius20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Save address',
                      style: TextStyle(
                          fontSize: config.font16,color: Colors.white),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
