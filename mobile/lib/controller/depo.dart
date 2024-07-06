import 'dart:convert';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/model/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Depo {

  final SharedPreferences sharedPreferences;

  Depo({required this.sharedPreferences});

  List<String> cartList=[];
  List<String> cartPreviousList=[];

  void addToCartList(List<CartModel> cartModel){
    cartList =[];

    cartModel.forEach((element) {
      element.time = DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
      print("Element "+ element.toString());
      return cartList.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CartList_SH_P, cartList);
    print(sharedPreferences.getStringList(AppConstants.CartList_SH_P));
  }

  List<CartModel> getCartModel() {
    List<String> cart = [];

    if(sharedPreferences.containsKey(AppConstants.CartList_SH_P)){
      cart = sharedPreferences.getStringList(AppConstants.CartList_SH_P)!;
      // print('inside getCartModel ${cart}');
    }

    List<CartModel> cartModel = [];
    
    cart.forEach((element) => cartModel.add(CartModel.fromJson(jsonDecode(element))));
    
    return cartModel;
  }
  List<CartModel> getCartPreviousModel() {
    List<String> cartPrevious = [];

    if(sharedPreferences.containsKey(AppConstants.CartHistoryList_SH_P)){
      cartPrevious = sharedPreferences.getStringList(AppConstants.CartHistoryList_SH_P)!;
      // print('inside getCartModel ${cart}');
    }

    List<CartModel> cartPreviousModel = [];

    cartPrevious.forEach((element) => cartPreviousModel.add(CartModel.fromJson(jsonDecode(element))));

    return cartPreviousModel;
  }

  void addToPreviousList(){
    if(sharedPreferences.containsKey(AppConstants.CartHistoryList_SH_P)){
      cartPreviousList = sharedPreferences.getStringList(AppConstants.CartHistoryList_SH_P)!;
    }

    for(int i=0; i<cartList.length;i++){
      cartPreviousList.add(cartList[i]);
    }
    print('inside  ${cartPreviousList}');
    removeCardList();
    sharedPreferences.setStringList(AppConstants.CartHistoryList_SH_P, cartPreviousList);
  }

  void removeCardList(){
    cartList=[];
    sharedPreferences.remove(AppConstants.CartList_SH_P);
  }
}