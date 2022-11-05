import 'package:ecommerce_app/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BigAppIcon(icon: Icons.sailing, iconSize: 50,backGroundColor: Colors.black,size: 70,)),
    );
  }
}
