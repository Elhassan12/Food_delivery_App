// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconAndTextWidget extends StatelessWidget {
  IconAndTextWidget(
      {Key? key,
      required this.text,
      required this.icon,
      required this.iconColor,})
      : super(key: key);


  final String text;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        SizedBox(
          width: 5,),
        SmallText(text: text)
      ],
    );
  }
}
