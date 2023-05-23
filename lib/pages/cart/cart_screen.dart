// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:ecommerce_app/base/no_date_page.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/controllers/cart_controller/cart_controller.dart';
import 'package:ecommerce_app/controllers/location_controller/location_controller.dart';
import 'package:ecommerce_app/route_helper/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/app_icon.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:ecommerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller/auth_controller.dart';
import '../../controllers/popular_controller/popular_product_controller.dart';
import '../../controllers/recommended_controller/recommended_controller.dart';
import '../../models/cart_model/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartController>(builder: (cartController) {
        return Stack(
          children: [
            Positioned(
              top: Dimensions.height30 * 2,
              right: Dimensions.width20,
              left: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppIcon(
                        icon: Icons.arrow_back_ios_new_outlined,
                        backGroundColor: AppColors.mainColor,
                        iconColor: Colors.white),
                  ),
                  SizedBox(
                    width: Dimensions.width20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.initial);
                    },
                    child: AppIcon(
                        icon: Icons.home_outlined,
                        backGroundColor: AppColors.mainColor,
                        iconColor: Colors.white),
                  ),
                  Badge(
                      child: AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          backGroundColor: AppColors.mainColor,
                          iconColor: Colors.white),
                      badgeContent: BigText(
                        text: Get.find<PopularProductController>()
                            .totalItems
                            .toString(),
                        size: Dimensions.font16,
                        color: Colors.white,
                      ),
                      showBadge:
                          Get.find<PopularProductController>().totalItems >= 1,
                      badgeColor: AppColors.mainColor),
                ],
              ),
            ),
            GetBuilder<CartController>(builder:(controller){

              return controller.getItems.isNotEmpty? Positioned(
                top: Dimensions.height20 * 6,
                bottom: 0,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Container(
                  // color: Colors.redAccent,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController) {
                      List<CartModel> cartItems = cartController.getItems;
                      return ListView.builder(
                          itemCount: cartController.getItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.maxFinite,
                              height: Dimensions.height20 * 5,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(
                                          cartItems[index].product!);
                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,'CartScreen'));

                                      }else{
                                        var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(
                                            cartItems[index].product!);
                                        if(recommendedIndex<0)
                                        {
                                          Get.snackbar(
                                            'History product',
                                            "product review is not available for history",
                                            backgroundColor: Colors.grey,
                                            colorText: Colors.white,
                                          );
                                        }else
                                        {
                                          Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,'CartScreen'));
                                        }


                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height15),
                                      width: Dimensions.width20 * 5,
                                      height: Dimensions.height20 * 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                Constant.BASE_URL +Constant.IMG+
                                                    Constant.UPLOADS +
                                                    cartController
                                                        .getItems[index].img!),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: cartController
                                                .getItems[index].name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(text: "spicy"),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: "\$"+cartController
                                                    .getItems[index].price
                                                    .toString(),
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    right: Dimensions.width10,
                                                    left: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                                ),
                                                child: GetBuilder<
                                                    PopularProductController>(
                                                    builder: (popularProduct) {
                                                      return Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                  cartItems[index]
                                                                      .product!,
                                                                  -1);
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              color:
                                                              AppColors.signColor,
                                                              size: Dimensions
                                                                  .iconSize30,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                            Dimensions.width20 /
                                                                2,
                                                          ),
                                                          BigText(
                                                              text: cartController
                                                                  .getItems[index]
                                                                  .quantity!
                                                                  .toString()),
                                                          SizedBox(
                                                            width:
                                                            Dimensions.width20 /
                                                                2,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                  cartItems[index]
                                                                      .product!,
                                                                  1);
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                              AppColors.signColor,
                                                              size: Dimensions
                                                                  .iconSize30,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                ),
              ): NoDatePage(text: "Your cart is empty!");
            })

          ],
        );
      }),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                right: Dimensions.width20,
                left: Dimensions.width20),
            height: Dimensions.bottomHeightBar,
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20 * 2),
                topLeft: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: cartController.getItems.length>0? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      right: Dimensions.width20,
                      left: Dimensions.width20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.width20 / 2,
                      ),
                      BigText(text: "\$"+"${cartController.totalAmount}"),
                      SizedBox(
                        width: Dimensions.width20 / 2,
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      right: Dimensions.width20,
                      left: Dimensions.width20),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: GestureDetector(
                    onTap: () {

                      if(Get.find<AuthController>().isUserLoggedIn()){
                       if(Get.find<LocationController>().addressList.isEmpty){
                         Get.toNamed(RouteHelper.getAddressPage());
                         cartController.addToCartHistoryList();
                       }
                      }else{
                        // Get.toNamed(RouteHelper.getSignInScreen());
                        print("you must Sign in first");
                      }
                      // cartController.addToCartHistoryList();
                    },
                    child: BigText(
                      text: ' | Add to Cart ',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ): Container(),
          );
        },
      ),
    );
  }
}
