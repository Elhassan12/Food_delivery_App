// ignore_for_file: unnecessary_new, prefer_const_constructors, avoid_print

import 'package:ecommerce_app/auth/sign_in_page/sign_in_page.dart';
import 'package:ecommerce_app/base/custom_message.dart';
import 'package:ecommerce_app/controllers/auth_controller/auth_controller.dart';
import 'package:ecommerce_app/models/sign_up_model/sign_up_model.dart';
import 'package:ecommerce_app/route_helper/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/app_text_field.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:ecommerce_app/widgets/custom_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

 void _registration(AuthController authController) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    if (!GetUtils.isEmail(email)) {
      customMessage("Type a valid email", "Email", Status.FAILD);

    } else if (password.isEmpty) {
      customMessage("Type your password", "Password", Status.FAILD);

    } else if (password.length <= 6) {
      customMessage(
          "Password must be more than 6 digits", "Password", Status.FAILD);

    } else if (name.isEmpty) {
      customMessage("Type your name", "Name", Status.FAILD);

    } else if (phone.isEmpty) {
      customMessage("Type your phone", "Phone", Status.FAILD);

    } else{

      customMessage("Signed up successfully", "Prefect", Status.SUCCESS);
      SignUpBody signUpBody = new SignUpBody(
          email: email, password: password, name: name, phone: phone);
      authController.registration(signUpBody).then((status){
        // if(status.isSuccess){
        //   print('success registration');
        // }else{
        //   customMessage(status.message, "Registration failed", Status.FAILD);
        // }
        Get.offNamed(RouteHelper.initial);

      });

    }
  }

  @override
  Widget build(BuildContext context) {
    var signUPImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              Container(
                height: Dimensions.screenHeight * 0.27,
                child: Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/image/logo part 1.png"),
                  ),
                ),
              ),
              //Email
              AppTextField(
                  textFieldController: emailController,
                  hintText: "Email",
                  prefixIcon: Icons.email),
              SizedBox(
                height: Dimensions.height15,
              ),
              // Password
              AppTextField(
                  textFieldController: passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                isObscure: true,
              ),
              SizedBox(
                height: Dimensions.height15,
              ),
              //Name
              AppTextField(
                  textFieldController: nameController,
                  hintText: "Name",
                  prefixIcon: Icons.person),
              SizedBox(
                height: Dimensions.height15,
              ),
              //  Phone Number
              AppTextField(
                  textFieldController: phoneController,
                  hintText: "Phone Number",
                  prefixIcon: Icons.phone),
              SizedBox(
                height: Dimensions.height30,
              ),
              GestureDetector(
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenWidth / 6,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30)),
                  child: Center(
                      child: BigText(
                        text: "Sign up",
                        color: Colors.white,
                        size: Dimensions.font26,
                      )),
                ),
                onTap: () {
                  _registration(_authController);
                },
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              RichText(
                  text: TextSpan(
                    text: "Have an account already?",
                    recognizer: TapGestureRecognizer()..onTap = ()=>Get.to(SignInPage(), transition: Transition.fadeIn),
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Colors.grey[500],
                    ),
                  )),
              SizedBox(
                height: Dimensions.screenHeight * 0.03,
              ),
              RichText(
                  text: TextSpan(
                    text: "Sign up using one of the following methods",
                    style: TextStyle(
                      fontSize: Dimensions.font16,
                      color: Colors.grey[500],
                    ),
                  )),
              SizedBox(
                height: 2,
              ),
              Wrap(
                children: List.generate(
                    3,
                        (index) => Padding(
                      padding: EdgeInsets.all(Dimensions.height10),
                      child: CircleAvatar(
                        radius: Dimensions.radius30,
                        backgroundImage:
                        AssetImage("assets/image/" + signUPImages[index]),
                      ),
                    )),
              ),
            ],
          ),
        ): CustomLoader();
      })
    );
  }
}
