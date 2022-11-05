import 'dart:convert';

import 'package:ecommerce_app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});
  List<String> cart= [];
  List<String> cartHistory= [];

  addToCartList(List<CartModel> cartList )
  {
    // sharedPreferences.remove(Constant.CART_HISTORY_LIST);
    // sharedPreferences.remove(Constant.CART_LIST);
    cart=[];
    var time =DateTime.now().toString();
    cartList.forEach((element) {
      element.time= time;
      cart.add(jsonEncode(element));
    });
     sharedPreferences.setStringList(Constant.CART_LIST, cart);
     // print(cart);
     // getCartList();
  }
  List<CartModel> getCartList()
  { List<String> carts=[];
    if(sharedPreferences.containsKey(Constant.CART_LIST))
      {
        carts=sharedPreferences.getStringList(Constant.CART_LIST)!;
      }
    List<CartModel> cartList=[];
    carts.forEach((element) {
      cartList.add(CartModel.formJson(jsonDecode(element)));

    });
    return cartList;
  }
  void addToCartHistoryList()
  {
    if(sharedPreferences.containsKey(Constant.CART_HISTORY_LIST)){
      cartHistory=sharedPreferences.getStringList(Constant.CART_HISTORY_LIST)!;
    }
    for(int i=0;i<cart.length;i++)
      {
        cartHistory.add(cart[i]);
      }
    removeCart();
    sharedPreferences.setStringList(Constant.CART_HISTORY_LIST, cartHistory);
    getHistoryList();

  }
  void removeCart()
  {
    cart=[];
    sharedPreferences.remove(Constant.CART_LIST);
  }
  List<CartModel> getHistoryList()
  {
    List<CartModel> historyList=[];
  if(sharedPreferences.containsKey(Constant.CART_HISTORY_LIST)) {
    cartHistory=[];
    cartHistory=sharedPreferences.getStringList(Constant.CART_HISTORY_LIST)!;

    print(cartHistory.length.toString()+" items in history" );

  }
  cartHistory.forEach((element) {
    historyList.add(CartModel.formJson(jsonDecode(element)));
  });
  return historyList ;
  }
}