import 'package:ecommerce_app/models/product_model/product_model.dart';

class CartModel {
  int? id;
  String? name;
  String? img;
  String? time;
  int? quantity;
  int? price;
  bool? isExist;
  Products? product;

  CartModel({
    this.id,
    this.name,
    this.img,
    this.time,
    this.quantity,
    this.price,
    this.isExist,
    this.product,
  });

  CartModel.formJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    img = json["img"];
    time = json["time"];
    quantity = json["quantity"];
    price = json["price"];
    isExist = json["isExist"];
    product = Products.fromJson(json["product"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'img': this.img,
      'time': this.time,
      'quantity': this.quantity,
      'price': this.price,
      'isExist': this.isExist,
      'product': this.product!.toJson(),
    };
  }
}
