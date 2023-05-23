import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Constant
{
  //App Info

  static const String APP_NAME = 'Food_delivery_app';
  static const String APP_VERSION = '1';

  //Base Url
   static const String BASE_URL = "http://mvs.bslmeiyu.com";

   static const String IMG = '';

  // FOOD END POINTS
  static const String POPULAR_FOOD = '/api/v1/products/popular';
  static const String RECOMMENDED_FOOD = '/api/v1/products/recommended';

  // User And Auth End Points
  static const String REGISTRATION_URI = '/api/v1/auth/register';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String USER_INFO_URI = '/api/v1/customer/info';

  static const String UPLOADS = '/uploads/';
  static const String CART_LIST = 'cart-list';
  static const String CART_HISTORY_LIST = 'cart-history-list';

//  User info
  static const String EMAIL = "";
  static const String USER_ADDRESS = "user-address";
  static const String TOKEN = "";
  static const String PASSWORD = "";

//  GEOCODE URI

  static const String GEOCODE_URI = "/api/v1/config/geocode-api";



}