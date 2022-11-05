// ignore_for_file: prefer_const_literals_to_create_immutables


import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText=true;


  double textHeight= Dimensions.screenHeight/5.63;


  @override
  void initState()
  {
    super.initState();
    if(widget.text.length>textHeight)
      {
        firstHalf= widget.text.substring(0,textHeight.toInt());
        secondHalf= widget.text.substring(textHeight.toInt()+1,widget.text.length);
      }else
        {
          firstHalf=widget.text;
          secondHalf ='';
        }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty ?SmallText(height: 1.8, size: Dimensions.font16 ,text: firstHalf,color: AppColors.textColor):Column(
        children: [
          SmallText(height: 1.8, size: Dimensions.font16,text: hiddenText? firstHalf+'...' : widget.text,color: AppColors.textColor),
          InkWell(
            onTap: (){
             setState(() {
               hiddenText=!hiddenText;
             });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SmallText(height: 1.8, size: Dimensions.font16,text: "show more",color: AppColors.mainColor,),
                Icon(!hiddenText? Icons.arrow_drop_up:Icons.arrow_drop_down_outlined , color: AppColors.mainColor,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
