import 'package:ecommerce_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/sign_up_model/sign_up_model.dart';
import '../../api/api_client.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient,required this.sharedPreferences});

 Future<Response> registration(SignUpBody signUpBody) async{
   return await apiClient.post(Constant.REGISTRATION_URI, signUpBody.toJson());
  }


 Future<bool> saveUserToken(String token)
  async {
    apiClient.token = token;
    apiClient.updateHeaders(token);
    return await sharedPreferences.setString(Constant.TOKEN, token);
  }

  Future<Response> login(String email, String password) async{
    return await apiClient.post(Constant.LOGIN_URI, {"email" :email, "password" : password});
  }

  Future<void> saveEmailAndPassword(String email, String password)async {
   try{
     await sharedPreferences.setString(Constant.EMAIL, email);
     await sharedPreferences.setString(Constant.PASSWORD, password);

   }catch(e){
     throw e;
   }
  }

  bool isUserLoggedIn(){
   return sharedPreferences.containsKey(Constant.TOKEN);
  }


  Future<String> getUserToken() async{
 return await sharedPreferences.getString(Constant.TOKEN)??"";
 }

 bool clearSharedPreferencesData(){
   sharedPreferences.remove(Constant.TOKEN);
   sharedPreferences.remove(Constant.EMAIL);
   sharedPreferences.remove(Constant.PASSWORD);
   apiClient.token = '';
   apiClient.updateHeaders('');
   return true;
 }


}