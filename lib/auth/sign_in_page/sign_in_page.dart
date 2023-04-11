import 'package:ecommerce_app/auth/sign_up_page/sign_up_page.dart';
import 'package:ecommerce_app/route_helper/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/app_text_field.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:ecommerce_app/widgets/custom_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_message.dart';
import '../../controllers/auth_controller/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();


    bool _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (!GetUtils.isEmail(email)) {
        customMessage("Type a valid email", "Email", Status.FAILD);
        return false;
      } else if (password.isEmpty) {
        customMessage("Type your password", "Password", Status.FAILD);
        return false;
      } else if (password.length <= 6) {
        customMessage(
            "Password must be more than 6 digits", "Password", Status.FAILD);
        return false;
      }  else {
        authController.login(email, password).then((status){
          if(status.isSuccess){
           Get.toNamed(RouteHelper.getInitial());

          }else{
            customMessage(status.message, "Sign in failed", Status.FAILD);
          }
        });
        return true;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body:GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              //app logo
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
              //welcome
              SizedBox(
                height: Dimensions.height15,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    bottom: Dimensions.height20,
                    left: Dimensions.height20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font26 * 3,
                          fontWeight: FontWeight.bold),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Sign into your account",
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: Dimensions.font20),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    //Email
                  ],
                ),
              ),
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
                height: Dimensions.height10,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                        text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                            fontSize: Dimensions.font20,
                            color: Colors.grey[500],
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Center(
                child: GestureDetector(
                  child: Container(
                    width: Dimensions.screenWidth / 2,
                    height: Dimensions.screenWidth / 6,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius30)),
                    child: Center(
                        child: BigText(
                          text: "Sign in",
                          color: Colors.white,
                          size: Dimensions.font26,
                        )),
                  ),
                  onTap: () {
                    _login(authController);
                  },
                ),
              ),
              SizedBox(
                height: Dimensions.height25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimensions.font20),
                      children: [
                        TextSpan(
                          text: " Create",
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignUpScreen(),transition: Transition.fadeIn),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Dimensions.font20),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ): CustomLoader();
      }) ,
    );
  }
}
