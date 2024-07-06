import 'package:flutter/material.dart';
import 'package:food_delivery/componants/snack_bar.dart';
import 'package:food_delivery/controller/apiclint.dart';
import 'package:food_delivery/model/user_model.dart';
import 'package:food_delivery/pages/Home/HomePage.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController implements GetxService{
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  UserController({required this.apiClient, required this.sharedPreferences});
  bool isLoading = false;
  UserModel? userModel;

  Future getUser() async{
    Response response = await apiClient.getData(AppConstants.UserURI);

    if(response.statusCode == 200){
      userModel = UserModel.fromJson(response.body);
      print('user details got successful');
      isLoading = true;
      update();

      // return print('Output is ' + response.statusText!);
    }else{
      isLoading = false;
      update();

      return print('Error is ' + response.statusText! + ' status is ' + response.statusCode.toString());
    }
  }
}