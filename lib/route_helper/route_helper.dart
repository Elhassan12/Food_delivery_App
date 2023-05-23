import 'package:ecommerce_app/pages/add_address_page.dart';
import 'package:ecommerce_app/pages/cart/cart_screen.dart';
import 'package:ecommerce_app/pages/food/popular_food_detail.dart';
import 'package:ecommerce_app/pages/food/recommended_food_detail.dart';
import 'package:ecommerce_app/pages/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

import '../auth/sign_in_page/sign_in_page.dart';
import '../pages/home_page/home_page.dart';
import '../pages/home_page/main_food_page.dart';


class RouteHelper {
  static const initial = '/';
  static String getInitial() => '$initial';


  static const popularFood = '/popular-food';
  static String getPopularFood(int pageId,String page) => '$popularFood?pageId=$pageId&page=$page';


  static const recommendedFood = '/recommended-food';
  static String getRecommendedFood(int pageId,String page) => '$recommendedFood?pageId=$pageId&page=$page';

  static const shoppingCart = '/shopping-cart';
  static String getShoppingCart() => '$shoppingCart';

  static const splashScreen = '/splash-screen';
  static String getSplashScreen() => '$splashScreen';

  static const signIn = '/signIn-screen';
  static String getSignInScreen() => '$signIn';
  static const addAddressPage = '/addAddress-screen';
  static String getAddressPage() => '$addAddressPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page: ()=>HomePage(),
    transition: Transition.fadeIn,
    ),

    GetPage(name: signIn, page: ()=>SignInPage(),
    transition: Transition.fadeIn,
    ),

    GetPage(
      name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page =Get.parameters['page'];
       return PopularFoodDetail(pageId: int.parse(pageId!),page:page.toString());
       },
    transition: Transition.fadeIn,
    ),

    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page =Get.parameters['page'];
      return RecommendedFoodDetail(pageId: int.parse(pageId!),page:page.toString());},
    transition: Transition.fadeIn,
    ),

    GetPage(name: shoppingCart, page: (){
      return CartScreen();},
    transition: Transition.fadeIn,
    ),

    GetPage(name: splashScreen, page: (){
      return SplashScreen();},
    transition: Transition.fadeIn,
    ),
    GetPage(name: addAddressPage, page: (){
      return AddAddressPage();},
    transition: Transition.fadeIn,
    ),


  ];
}
