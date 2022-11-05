import 'package:get/get.dart';

//  height is 840 ti get the factor

class Dimensions{
  //Dimensions of the device screen
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;


  static double pageView = screenHeight/2.64;
  static double pageViewContainer = screenHeight/3.84;
  static double pageViewTextContainer = screenHeight/7.03;

  //dynamic height
  static double height10 = screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20 = screenHeight/42.2;
  static double height30 = screenHeight/28.13;
  static double height45 = screenHeight/18.76;

  //dynamic width, margin and padding
  static double width10 = screenHeight/84.4;
  static double width15 = screenHeight/56.27;
  static double width20 = screenHeight/42.2;
  static double width30 = screenHeight/28.13;

  // dynamic radius
  static double font16 = screenHeight/52.5;
  static double font20 = screenHeight/42.2;
  static double font26 = screenHeight/32.3;

  // dynamic radius
  static double radius15 = screenHeight/56.27;
  static double radius20 = screenHeight/42.2;
  static double radius30 = screenHeight/28.13;

  // dynamic iconSize
  static double iconSize30 = screenHeight/28;
  static double iconSize24 = screenHeight/35.17;
  static double iconSize20 = screenHeight/42;
  static double iconSize16 = screenHeight/52.75;


 //  dynamic page view Container size
  static double listViewImageSize = screenWidth/3.25;
  static double listViewTextContSize = screenWidth/3.9;

//  popular food size

  static double popularFoodImgSize = screenHeight/2.41;

//  bottom height

  static double bottomHeightBar = screenHeight/7.03;


  // splash screen
  static double splashScreenImg = screenHeight/3.3;






















}