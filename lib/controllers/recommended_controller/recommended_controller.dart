import 'package:ecommerce_app/controllers/cart_controller/cart_controller.dart';
import 'package:ecommerce_app/controllers/popular_product_controller.dart';
import 'package:ecommerce_app/data/repository/popular_product_repo.dart';
import 'package:ecommerce_app/data/repository/recommended_repo/recommended_repo.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model/product_model.dart';

class RecommendedProductController extends GetxController
{

  final RecommendedProductRepo recommendedProductRepo ;
  RecommendedProductController({required this.recommendedProductRepo});
  List<Products> _recommendedProductList = [];
  bool _isLoaded =false;
  bool get isLoaded => _isLoaded;


  List<Products> get recommendedProductList => _recommendedProductList;

  Future<void> getRecommendedProductList( )async
  {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200)
    {

      _recommendedProductList =[];
      _recommendedProductList.addAll(ProductModel.fromJson(response.body).products!);
      _isLoaded=true;
      update();
    }else
    {
      if (kDebugMode) {
        print(response.statusCode.toString());
        print(response.statusText.toString());
      }
    }


  }








}