import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/controller/apiclint.dart';
import 'package:food_delivery/model/address_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends GetxController implements GetxService {
  ApiClient apiClient;
  SharedPreferences sharedPreferences;

  AddressController(this.apiClient, this.sharedPreferences);

  bool isLoading = false;
  late Position position;
  late Position pickPosition;
  Placemark placemark = Placemark();
  Placemark pickPlacemark = Placemark();
  List<AddressModel> addressList = [];
  late List<AddressModel> allAddressList;
  List<String> addressTypeList = ['Home', 'Office', 'Others'];
  int addressTypeListIndex = 0;
  Map<String, dynamic>? getAddress;
  late GoogleMapController googleMapController;
  bool updateAddressData = true;
  bool changeAddress = true;
  void setGoogleMapController(GoogleMapController gMController) {
    googleMapController = gMController;
  }

  void updateAddress(CameraPosition cPosition, bool fromAddress) async{
    if (updateAddressData) {
      isLoading = true;
      update();
      try {
        if (fromAddress) {
          position = Position(
              longitude: cPosition.target.longitude,
              latitude: cPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              altitudeAccuracy: 1,
              heading: 1,
              headingAccuracy: 1,
              speed: 1,
              speedAccuracy: 1);
        }else{
          pickPosition = Position(
              longitude: cPosition.target.longitude,
              latitude: cPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              altitudeAccuracy: 1,
              heading: 1,
              headingAccuracy: 1,
              speed: 1,
              speedAccuracy: 1);
        }

        if(changeAddress){
          String address = await getAddressFromGeocode(
            LatLng(cPosition.target.latitude, cPosition.target.longitude)
          );
          fromAddress ? placemark = Placemark(name: address) : pickPlacemark = Placemark(name: address);
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future getAddressFromGeocode(LatLng latLng) async{
    String address = 'Unknown address found!';
    Response response = await apiClient.getData('${AppConstants.GeoCodeURI}?lat=${latLng.latitude}&lng=${latLng.longitude}');
    if(response.body['status'] == 'OK'){
      address = response.body['results'][0]['formatted_address'].toString();
    }else{
      print('Error in getting geo api');
    }
    return address;
  }

  AddressModel getUserAddress(){
    late AddressModel addressModel;
    getAddress = jsonDecode(sharedPreferences.getString(AppConstants.UserAddress)!);
    try{
      addressModel = jsonDecode(sharedPreferences.getString(AppConstants.UserAddress)!);
    }catch(e){
      print(e.toString());
    }

    return addressModel;
  }

  void setAddressTypeIndex(int index){
    addressTypeListIndex = index;
  }

  Future addNewAddress(AddressModel addressModel) async{
      isLoading = true;
      update();
      Response response = await apiClient.postData(AppConstants.AddAddressURI, addressModel.toJson());

      if(response.statusCode == 200){
        await getAllAddress();
        print('Address added successfully : ${response.body['message']}');
        await saveUserAddress(addressModel);
        return true;
      }else{
        print('Address doesn\'t added');
        return false;
      }
  }

  Future getAllAddress() async {
    isLoading = true;
    update();
    Response response = await apiClient.getData(AppConstants.AddAddressURI);

    if(response.statusCode==200){
      allAddressList = [];
      addressList = [];
      response.body.forEach((address){
        allAddressList.add(AddressModel.fromJson(address));
        addressList.add(AddressModel.fromJson(address));
      });
    }else{
      addressList = [];
      allAddressList = [];
    }
  }

  Future saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await sharedPreferences.setString(AppConstants.UserAddress, userAddress);
  }

  void clearaddressList(){
    addressList = [];
    allAddressList = [];
    update();
  }
}
