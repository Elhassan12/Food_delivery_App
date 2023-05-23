import 'package:get/get.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/data/api/api_client.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
   SharedPreferences sharedPreferences;
   ApiClient apiClient;

  LocationRepo({required this.apiClient,required this.sharedPreferences});

 Future<Response> getAddressFromGeocoding(LatLng position) async{
    return await apiClient.getData('${Constant.GEOCODE_URI}''?lat=${position.latitude}&log=${position.longitude}');

  }

  String getUserAddress(){
   return sharedPreferences.getString(Constant.USER_ADDRESS)??"";
  }


}