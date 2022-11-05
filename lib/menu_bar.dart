import 'package:ecommerce_app/pages/splash_screen/splash_screen.dart';
import 'package:ecommerce_app/route_helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(child: Text("first"),value: 1,),
            PopupMenuItem(child: Text("second"),value: 2,),
          ],
            child: Icon(Icons.add),
            onSelected: (value) {
            if(value==1) {
              Get.toNamed(RouteHelper.splashScreen);
            }
            },
            enabled: true,
            initialValue: 1,
            onCanceled: (){
            Get.snackbar("PopUp Menu has been Cancelled", "");
            },
          ),
        ],
      ),
    );
  }
}
