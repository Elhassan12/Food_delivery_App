// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/controllers/popular_product_controller.dart';
import 'package:ecommerce_app/controllers/recommended_controller/recommended_controller.dart';
import 'package:ecommerce_app/models/product_model/product_model.dart';
import 'package:ecommerce_app/route_helper/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:ecommerce_app/widgets/icon_and_text_widget.dart';
import 'package:ecommerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  var pageController = PageController(viewportFraction: .85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  Dimensions D = Dimensions();

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider section
        GetBuilder<PopularProductController>(builder: (controller){
          return Container(
            height: Dimensions.pageView,
            // color: Colors.redAccent,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return controller.isLoaded?_buildPageItem(index,Get.find<PopularProductController>().popularProductList[index]):Center(child: CircularProgressIndicator());
              },
              itemCount:Get.find<PopularProductController>().popularProductList.length ,
              physics: BouncingScrollPhysics(),
            ),
          );
        }),
        //Dots section
        GetBuilder<PopularProductController>(builder: (controller){
          return DotsIndicator(
            dotsCount: controller.isLoaded? Get.find<PopularProductController>().popularProductList.length:6  ,
            position: _currPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor: AppColors.mainColor,
            ),
          );
        }),
        // Popular text
        SizedBox(
          height: Dimensions.height30,
        ),

        // Recommended Food Title Section
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 1),
                child: SmallText(text: 'Food pairing'),
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
            ],
          ),
        ),

        // Recommended Food Body Section
        GetBuilder<RecommendedProductController>(builder: (controller){
          List<Products> prodcuts =Get.find<RecommendedProductController>().recommendedProductList;
          return  Get.find<RecommendedProductController>().isLoaded?  ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(index,'home'));
                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width20 ,right: Dimensions.width20 ,bottom: Dimensions.height10 ),
                  child: Row(
                    children: [
                      Container(
                        height: Dimensions.listViewImageSize,
                        width: Dimensions.listViewImageSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.width30),
                          color: Colors.white24,
                          image: DecorationImage(
                              image: NetworkImage(Constant.BASE_URL+Constant.UPLOADS+prodcuts[index].img!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextContSize,
                          decoration:BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.only(left: Dimensions.width10,right:Dimensions.width10,top: Dimensions.height10 ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: prodcuts[index].name!),
                                SizedBox(height: Dimensions.height10,),
                                SmallText(text: 'with chinese characteristics'),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                        text: 'Normal',
                                        icon: Icons.circle_sharp,
                                        iconColor: AppColors.iconColor1),
                                    IconAndTextWidget(
                                        text: '1.7km',
                                        icon: Icons.location_on,
                                        iconColor: AppColors.mainColor),
                                    IconAndTextWidget(
                                        text: '39',
                                        icon: Icons.access_time,
                                        iconColor: AppColors.iconColor2),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount:Get.find<RecommendedProductController>().isLoaded ?Get.find<RecommendedProductController>().recommendedProductList.length:5 ,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ):Center(child: CircularProgressIndicator());
        }),

      ],
    );
  }

  Widget _buildPageItem(index,Products product) {
    Matrix4 martix = new Matrix4.identity();
    if (index == _currPageValue.floor()) // for current widget
    {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      // var currScale=1.0;
      var currtrans = _height * (1 - currScale) / 2;
      martix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      //for right widget
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      // var currScale= _scaleFactor;
      var currtrans = _height * (1 - currScale) / 2;
      martix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      // for left widget

      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      // var currScale= _scaleFactor;
      var currtrans = _height * (1 - currScale) / 2;
      martix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      // to fix the translation in right widget
      var currScale = 0.8;
      var currtrans = _height * (1 - currScale) / 2;
      martix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    }

    return Transform(
      transform: martix,
      child: Stack(
        children: [
          //big box
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index,'home'));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.height10, right: Dimensions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                image: DecorationImage(
                    image:NetworkImage(Constant.BASE_URL+Constant.UPLOADS+product.img!),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          // small box
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.height20,
                  right: Dimensions.height20,
                  bottom: Dimensions.height15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF8e8e8e),
                    offset: Offset(0, 5),
                    blurRadius: 5.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.height20,
                    right: Dimensions.height20,
                    top: Dimensions.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: product.name!,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: AppColors.mainColor,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: '4.5'),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: '1287'),
                        SizedBox(
                          width: 5,
                        ),
                        SmallText(text: 'Comments'),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                            text: 'Normal',
                            icon: Icons.circle_sharp,
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            text: '1.7km',
                            icon: Icons.location_on,
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            text: '39',
                            icon: Icons.access_time,
                            iconColor: AppColors.iconColor2),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
