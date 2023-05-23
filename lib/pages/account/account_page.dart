import 'dart:ffi';

import 'package:ecommerce_app/controllers/account_controller/account_controller.dart';
import 'package:ecommerce_app/controllers/auth_controller/auth_controller.dart';
import 'package:ecommerce_app/controllers/cart_controller/cart_controller.dart';
import 'package:ecommerce_app/data/repository/cart_repo/cart_repo.dart';
import 'package:ecommerce_app/route_helper/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/account_widget.dart';
import 'package:ecommerce_app/widgets/app_icon.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:ecommerce_app/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    if (isUserLoggedIn) {
      Get.find<AccountController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Center(
              child: BigText(
            text: "Profile",
            size: Dimensions.height25,
            color: Colors.white,
          ))),
      body: GetBuilder<AccountController>(builder: (userController) {
        return isUserLoggedIn
            ? (userController.isLoading
                ? CustomLoader()
                : Container(
                    margin: EdgeInsets.symmetric(vertical: Dimensions.height15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadiusDirectional.circular(80),
                              ),
                              child: Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height25,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                //name
                                AccountWidget(
                                    icon: AppIcon(
                                      icon: Icons.person,
                                      backGroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                    ),
                                    text: BigText(text: "Elhassan Ali")),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                //email
                                AccountWidget(
                                    icon: AppIcon(
                                      icon: Icons.email,
                                      backGroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                    ),
                                    text:
                                        BigText(text: "ElhassanAli@gmail.com")),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                //address
                                AccountWidget(
                                    icon: AppIcon(
                                      icon: Icons.location_on,
                                      backGroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                    ),
                                    text:
                                        BigText(text: "Fill in your address")),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                //phone Number
                                AccountWidget(
                                    icon: AppIcon(
                                      icon: Icons.phone,
                                      backGroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                    ),
                                    text: BigText(text: "01110357406")),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                //message
                                AccountWidget(
                                    icon: AppIcon(
                                      icon: Icons.message,
                                      backGroundColor: Colors.red,
                                      iconColor: Colors.white,
                                    ),
                                    text: BigText(text: "No message yet")),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                //message
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .isUserLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedPreferencesData();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      Get.offNamed(
                                          RouteHelper.getSignInScreen());
                                    } else
                                      print("you logged out");
                                  },
                                  child: AccountWidget(
                                      icon: AppIcon(
                                        icon: Icons.logout_outlined,
                                        backGroundColor: Colors.red,
                                        iconColor: Colors.white,
                                      ),
                                      text: BigText(text: "Logout")),
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            : Container(
                child: Center(
                  child: Text("YOU MUST LOGIN"),
                ),
              );
      }),
    );
  }
}
