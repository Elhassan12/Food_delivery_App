import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/data/api/api_client.dart';
import 'package:get/get.dart';

class AccountRepo extends GetxService{
  ApiClient apiClient;
  AccountRepo({required this.apiClient});

  Future<Response> getUserInfo() async{
 return await apiClient.getData(Constant.USER_INFO_URI);
  }
}