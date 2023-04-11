import 'dart:core';

import 'package:ecommerce_app/data/repository/cart_repo/cart_repo.dart';
import 'package:ecommerce_app/models/cart_model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model/product_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  set setItems(Map<int, CartModel> value) {
    _items={};
    _items = value;
  }

  Map<int, CartModel> get setItems => _items;


  void addItem(Products product, int quantity) {
    var _totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        _totalQuantity = quantity + value.quantity!;

        return CartModel(
          id: product.id,
          img: product.img,
          time: DateTime.now().toString(),
          quantity: quantity + value.quantity!,
          price: product.price,
          isExist: true,
          name: product.name,
          product: product,
        );
      });

      // to remove the item which its quantity equal to zero
      if (_totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
            product.id!,
            () => CartModel(
                id: product.id,
                img: product.img,
                name: product.name,
                time: DateTime.now().toString(),
                quantity: quantity,
                price: product.price,
                isExist: true,
              product: product,
            ));
      } else {
        Get.snackbar(
          'item count',
          "You should add an item at least",
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(Products product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(Products product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalItems = 0;
    _items.forEach((key, value) {
      totalItems += value.quantity!;
    });
    return totalItems;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  void setQuantity(bool increment, CartModel cart) {
    if (increment) {
      print("increment");
      if (_items.containsKey(cart.id)) {
        _items.forEach((key, value) {
          if (key == cart.id) {
            value.quantity = (value.quantity! + 1);
          }
          if (value.quantity! > 20) {
            value.quantity = 20;
          }
        });
      }
    }else {
      if (_items.containsKey(cart.id)) {
        _items.forEach((key, value) {
          if (key == cart.id) {
            value.quantity = (value.quantity! - 1);
          }
          if (value.quantity! < 0) {
            _items.remove(value.id);
          }
        });
      }
    }
    this.totalItems;
    update();
  }

  int get totalAmount
  {
    int total=0;
    _items.forEach((key, value) {
      total+=(value.price!*value.quantity!);
    });
    return total;
  }

  List<CartModel> storageItems=[];


  set setCart(List<CartModel> items)
  {
    storageItems=items;

    print('the length of items is '+storageItems.length.toString() );

    for(int i=0; i<storageItems.length;i++ )
      {
        _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
      }
  }
  List<CartModel> getCartData()
  {
    setCart = cartRepo.getCartList();
    return storageItems;
  }
  void addToCartHistoryList()
  {
    cartRepo.addToCartHistoryList();
    clear();
  }
  void clear()
  {
    _items={};
    update();
  }

 List<CartModel> getCartHistoryList()
 {
  return cartRepo.getHistoryList();
 }

 void addToCartList()
 {
   cartRepo.addToCartList(getItems);
   update();
 }


}
