import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backGroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const AppIcon({
    Key? key,
    required this.icon,
    this.backGroundColor = const Color(0xFFfcf4fe),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
    this.iconSize = 24,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backGroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: Dimensions.iconSize24,
      ),
    );
  }
}

class BigAppIcon extends AppIcon {
  final double iconSize;
  BigAppIcon(
      {required super.icon,
        required this.iconSize,
      super.backGroundColor = const Color(0xFFfcf4fe),
      super.iconColor = const Color(0xFF756d54),
      super.size = 40});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backGroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size:iconSize,
      ),
    );
  }

  }

