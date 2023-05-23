import 'package:ecommerce_app/auth/sign_in_page/sign_in_page.dart';
import 'package:ecommerce_app/auth/sign_up_page/sign_up_page.dart';
import 'package:ecommerce_app/controllers/cart_controller/cart_controller.dart';
import 'package:ecommerce_app/pages/add_address_page.dart';
import 'package:ecommerce_app/pages/cart/cart_screen.dart';
import 'package:ecommerce_app/pages/food/popular_food_detail.dart';
import 'package:ecommerce_app/pages/food/recommended_food_detail.dart';
import 'package:ecommerce_app/pages/home_page/main_food_page.dart';
import 'package:ecommerce_app/pages/splash_screen/splash_screen.dart';
import 'package:ecommerce_app/route_helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client_helper/dependencies.dart' as dep ;
import 'controllers/popular_controller/popular_product_controller.dart';
import 'controllers/recommended_controller/recommended_controller.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      title: 'E_commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:AddAddressPage(),
      // initialRoute:RouteHelper.getSplashScreen(),
      // getPages: RouteHelper.routes,
    );
  }
}
