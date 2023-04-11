import 'package:ecommerce_app/controllers/cart_controller/cart_controller.dart';
import 'package:ecommerce_app/data/repository/popular_product_repo.dart';
import 'package:ecommerce_app/models/cart_model/cart_model.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model/product_model.dart';

class PopularProductController extends GetxController
{

  final PopularProductRepo popularProductRepo ;
  PopularProductController({required this.popularProductRepo});
  List<Products> _popularProductList = [];
  bool _isLoaded =false;
  bool get isLoaded => _isLoaded;


  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProductList( )async
  {
  Response response = await popularProductRepo.getPopularProductList();
  if(response.statusCode==200)
    {
      _popularProductList =[];
      _popularProductList.addAll(ProductModel.fromJson(response.body).products!);

       // print("id "+_popularProductList[0].id.toString()+ "name " +_popularProductList[0].name.toString());
      _isLoaded=true;
      update();
    }else
      {
        if (kDebugMode) {
          print(response.statusCode.toString());
          print('error happened in popular product controller');
          print(response.statusText.toString());
        }
      }


  }
  
  int _quantity = 0;
  int _inCartItems=0;

  int get inCartItems => _inCartItems+_quantity;
  late  CartController _cart;


  int get quantity => _quantity;

  void setQuantity(bool isIncrement)
  {
    if(isIncrement)
      {
        _quantity= checkQuantity(_quantity+1);
        
      }else{
      _quantity= checkQuantity(_quantity-1);
    }
    print(_quantity.toString());
    update();
  }
  int checkQuantity(int quantity)
  {
    if(quantity+_inCartItems>20)
      {
        Get.snackbar('Item Count', "You can't add more!",
        backgroundColor: Colors.grey,
          colorText: Colors.white,

        );
        return 20 - _inCartItems;

      }else if(quantity+_inCartItems<0){
      Get.snackbar('Item Count', "You can't Reduce more!",
      backgroundColor: Colors.grey,
          colorText: Colors.white,);

      if(_inCartItems>0){
        _quantity=-_inCartItems;
        return _quantity;
      }

      return 0;

    }else{
      return quantity;
    }
  }
  void initProduct(Products product,CartController cart)
  {
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    // if exist
    var exist =false;
    exist = _cart.existInCart(product);
    if(exist){
      _inCartItems= _cart.getQuantity(product);
    }

  }

  void addItem(Products product)
  {
    // if(_quantity>0) {
      _cart.addItem(product, _quantity);

      // to can add more
      _quantity=0;

      // what we see in the UI
      _inCartItems = _cart.getQuantity(product);
    // }else
    //   {
    //
    //   }
    update();

  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get cartItems{
    return _cart.getItems;
  }

  void setQuantityInCart(bool increment,CartModel cart){
    _cart.setQuantity(increment, cart);
    update();

  }





}