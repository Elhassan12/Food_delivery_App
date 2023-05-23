import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/app_icon.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon icon;
  BigText text;
   AccountWidget({Key? key, required this.icon,required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.width10,horizontal: Dimensions.width20),
      decoration: BoxDecoration(
        boxShadow:[
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
            
          )
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: Dimensions.width20,
          ),
          text,
        ],
      ),
    );
  }
}
