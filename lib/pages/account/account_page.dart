import 'dart:ffi';

import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/account_widget.dart';
import 'package:ecommerce_app/widgets/app_icon.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Center(
              child: BigText(
            text: "Profile",
            size: Dimensions.height25,
            color: Colors.white,
          ))),
      body: Container(
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
                    borderRadius: BorderRadiusDirectional.circular(80),
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
                    SizedBox(height: Dimensions.height20,),
                    //email
                    AccountWidget(
                        icon: AppIcon(
                          icon: Icons.email,
                          backGroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                        ),
                        text: BigText(text: "ElhassanAli@gmail.com")),
                    SizedBox(height: Dimensions.height20,),
                    //address
                    AccountWidget(
                        icon: AppIcon(
                          icon: Icons.location_on,
                          backGroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                        ),
                        text: BigText(text: "Fill in your address")),
                    SizedBox(height: Dimensions.height20,),
                    //phone Number
                    AccountWidget(
                        icon: AppIcon(
                          icon: Icons.phone,
                          backGroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                        ),
                        text: BigText(text: "01110357406")),
                    SizedBox(height: Dimensions.height20,),
                    //message
                    AccountWidget(
                        icon: AppIcon(
                          icon: Icons.message,
                          backGroundColor: Colors.red,
                          iconColor:Colors.white,
                        ),
                        text: BigText(text: "No message yet")),
                    SizedBox(height: Dimensions.height20,),
                    //message
                    AccountWidget(
                        icon: AppIcon(
                          icon: Icons.message,
                          backGroundColor: Colors.red,
                          iconColor:Colors.white,
                        ),
                        text: BigText(text: "No message yet")),
                    SizedBox(height: Dimensions.height20,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
