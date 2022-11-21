import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foddies_app/base/custom_loader.dart';
import 'package:foddies_app/pages/auth/signup_page.dart';
import 'package:foddies_app/routes/route_helper.dart';
import 'package:foddies_app/utils/colors.dart';
import 'package:foddies_app/utils/dimensions.dart';
import 'package:foddies_app/widgets/app_text_field.dart';
import 'package:foddies_app/widgets/big_text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      var authController = Get.find<AuthController>();

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Type In your email address", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type In your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("password can not be less then 6 characters",
            title: "Name");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getCartPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      Gap(
                        Dimensions.screenHeight * 0.05,
                      ),

                      //App Logo
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage("assets/image/logo part 1.png"),
                          ),
                        ),
                      ),
                      //Welcome
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                    fontSize: Dimensions.font20 * 3.5,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      Gap(
                        Dimensions.screenHeight * 0.05,
                      ),
                      //Email
                      AppTextField(
                          textController: emailController,
                          hintText: "Email",
                          icon: Icons.email),
                      Gap(
                        Dimensions.height20,
                      ),
                      //password
                      AppTextField(
                          textController: passwordController,
                          hintText: "Password",
                          isObscure: true,
                          icon: Icons.password_sharp),
                      Gap(
                        Dimensions.height20,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: Dimensions.width30),
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20,
                                ),
                                text: "Sign into your account",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.back(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(Dimensions.screenHeight * 0.05),
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: BigText(
                              color: Colors.white,
                              text: "Sign In",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                            ),
                          ),
                        ),
                      ),
                      Gap(Dimensions.screenHeight * 0.05),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                          text: "Don\'t have an account?",
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => SignUpPage(),
                                    transition: Transition.fade),
                              style: TextStyle(
                                  color: AppColors.mainBlackColor,
                                  fontSize: Dimensions.font20,
                                  fontWeight: FontWeight.bold),
                              text: "Create",
                            )
                          ],
                        ),
                      ),
                      Gap(Dimensions.screenHeight * 0.05),
                    ]),
                  )
                : Center(child: CustomLoader());
          },
        ));
  }
}
