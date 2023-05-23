// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/controllers/recommended_controller/recommended_controller.dart';
import 'package:ecommerce_app/models/product_model/product_model.dart';
import 'package:ecommerce_app/route_helper/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:ecommerce_app/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller/cart_controller.dart';
import '../../controllers/popular_controller/popular_product_controller.dart';
import '../../widgets/app_icon.dart';
import 'package:badges/badges.dart';

import '../cart/cart_screen.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendedProductController>(builder: (controller) {
      Products product = Get.find<RecommendedProductController>()
          .recommendedProductList[pageId];
      Get.find<PopularProductController>()
          .initProduct(product, Get.find<CartController>());
      return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if(page=='CartScreen'){
                          Get.toNamed(RouteHelper.getShoppingCart());
                        }else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.close)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap:(){
                            // if(controller.totalItems>=1)
                              Get.toNamed(RouteHelper.getShoppingCart());
                            },
                          child: Badge(
                              child: AppIcon(icon: Icons.shopping_cart,),
                            badgeContent:  BigText(
                            text: Get.find<PopularProductController>()
                                .totalItems
                                .toString(),size: Dimensions.font16,
                            color: Colors.white,),
                          showBadge: Get.find<PopularProductController>().totalItems >= 1
                          ,badgeColor: AppColors.mainColor),
                        ),
                        // Get.find<PopularProductController>().totalItems >= 1
                        //     ? Positioned(
                        //         right: 0, top: 0,
                        //         child: AppIcon(
                        //           icon: Icons.circle,
                        //           size: 20,
                        //           backGroundColor: AppColors.mainColor,
                        //           iconColor: Colors.transparent,
                        //         ),
                        //       )
                        //     : Container(),
                        // Get.find<PopularProductController>().totalItems >= 1
                        //     ? Positioned(
                        //         right: 3, top: 3,
                        //         child: BigText(
                        //             text: Get.find<PopularProductController>()
                        //                 .totalItems
                        //                 .toString(),size: Dimensions.font16,))
                        //     : Container(),
                      ],
                    );
                  }),
                ],
              ),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(Dimensions.height10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius30),
                            topLeft: Radius.circular(Dimensions.radius30))),
                    child: Center(
                        child: BigText(
                      text: product.name!,
                      size: Dimensions.font26,
                    )),
                  )),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  Constant.BASE_URL + Constant.UPLOADS+Constant.IMG+ product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: ExpandableTextWidget(text: product.description!),
                    margin: EdgeInsets.only(
                        left: Dimensions.width10, right: Dimensions.width10),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20 * 2.5,
                    right: Dimensions.width20 * 2.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                            icon: Icons.remove,
                            iconColor: Colors.white,
                            backGroundColor: AppColors.mainColor)),
                    BigText(
                      text: '\$${product.price!} X ${controller.inCartItems}',
                      size: Dimensions.font26,
                      color: AppColors.mainBlackColor,
                    ),
                    InkWell(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                            icon: Icons.add,
                            iconColor: Colors.white,
                            backGroundColor: AppColors.mainColor)),
                  ],
                ),
              ),
              Container(
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
                child: Row(
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: InkWell(
                          onTap: () {
                            controller.addItem(product);
                          },
                          child: BigText(
                            text: '\$${product.price!} | Add to Cart ',
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
