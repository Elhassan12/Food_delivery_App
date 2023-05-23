import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Status {
  FAILD,
  SUCCESS,
}

void customMessage(String message, String title, Status status) {
  if (status == Status.FAILD) {
    Get.snackbar(title, message,
        backgroundColor: Colors.redAccent,
        titleText: BigText(text: title),
        messageText: Text(message));
  } else if(status == Status.SUCCESS) {
    Get.snackbar(title, message,
        backgroundColor: Colors.green,
        titleText: BigText(text: title),
        messageText: Text(message));
  }
}
