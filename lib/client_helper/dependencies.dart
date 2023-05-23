import 'package:ecommerce_app/controllers/auth_controller/auth_controller.dart';
import 'package:ecommerce_app/controllers/cart_controller/cart_controller.dart';
import 'package:ecommerce_app/controllers/location_controller/location_controller.dart';
import 'package:ecommerce_app/data/api/api_client.dart';
import 'package:ecommerce_app/data/repository/account_repo/account_repo.dart';
import 'package:ecommerce_app/data/repository/auth_repo/auth_repo.dart';
import 'package:ecommerce_app/data/repository/cart_repo/cart_repo.dart';
import 'package:ecommerce_app/data/repository/popular_product_repo.dart';
import 'package:ecommerce_app/data/repository/recommended_repo/recommended_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/account_controller/account_controller.dart';
import '../controllers/popular_controller/popular_product_controller.dart';
import '../controllers/recommended_controller/recommended_controller.dart';
import '../data/repository/location_repo/location_repo.dart';

Future<void> init()
async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);
  // Api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: "http://mvs.bslmeiyu.com",sharedPreferences: Get.find()));

  // Repos
  Get.lazyPut(()=>PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=>RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() =>AuthRepo(apiClient : Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(()=>CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(()=>AccountRepo(apiClient: Get.find()));
  Get.lazyPut(()=>LocationRepo(apiClient: Get.find(),sharedPreferences: Get.find()));

 //Controllers
  Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(()=>AuthController(authRepo: Get.find()));
  Get.lazyPut(()=>CartController(cartRepo: Get.find()));
  Get.lazyPut(()=>AccountController(authRepo: Get.find()));
  Get.lazyPut(()=>LocationController(locationRepo: Get.find()));



}