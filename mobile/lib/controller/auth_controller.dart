import 'package:flutter/material.dart';
import 'package:food_delivery/componants/snack_bar.dart';
import 'package:food_delivery/controller/apiclint.dart';
import 'package:food_delivery/pages/Home/HomePage.dart';
import 'package:food_delivery/pages/auth/auth_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController implements GetxService{
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  AuthController({required this.apiClient, required this.sharedPreferences});
  Map<String,dynamic> data = {};
  bool isLoading = false;

  void clearToekn(){
     sharedPreferences.remove(AppConstants.TOKEN);
     return print('token is ${sharedPreferences.getString(AppConstants.TOKEN)}');
  }

  Future Register(String name,String email, String password, String phone) async{
    isLoading = true;
    update();

    data = {'f_name':name,'email':email,'password':password,'phone':phone,};
    Response response = await apiClient.postData(AppConstants.RegisterURI, data);

    if(response.statusCode == 200){
      apiClient.updateToken(response.body['token']);
      print("Token is ${response.body['token']}");
      await sharedPreferences.setString(AppConstants.TOKEN, response.body['token']);
      Get.to(()=> HomePage());
      isLoading = false;
      update();
      print(response.statusText);
      return response.statusText;
    }else{
      isLoading = false;
      update();
      print(response.statusText);
      if(response.statusText == 'Forbidden') {
        return getSnackBar('Email or phone number already exist');
      }else{
        return getSnackBar(response.statusText!);
      }
    }
  }
  
  Future login(String email, String password) async{
    isLoading = true;
    update();
    
    data = {'email':email,'password':password};
    Response response = await apiClient.postData(AppConstants.LoginURI, data);

    if(response.statusCode == 200){
      apiClient.updateToken(response.body['token']);
      print("Token is ${response.body['token']}");
      await sharedPreferences.setString(AppConstants.TOKEN, response.body['token']);
      Get.to(()=> HomePage());
      isLoading = false;
      update();
      print('logged in successful');
      return response.statusText;
    }else{
      isLoading = false;
      update();
      print(response.statusText);
      return getSnackBar(response.statusText!);
    }
  }

  Future logout() async{
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.CartList_SH_P);

    Get.to(()=> AuthPage());
  }
}