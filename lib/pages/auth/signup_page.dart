import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foddies_app/base/custom_loader.dart';
import 'package:foddies_app/base/show_custom_snackbar.dart';
import 'package:foddies_app/controllers/auth_controller.dart';
import 'package:foddies_app/models/signup_body_model.dart';
import 'package:foddies_app/routes/route_helper.dart';
import 'package:foddies_app/utils/colors.dart';
import 'package:foddies_app/utils/dimensions.dart';
import 'package:foddies_app/widgets/app_text_field.dart';
import 'package:foddies_app/widgets/big_text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void _registraion(AuthController authController) {
      var authController = Get.find<AuthController>();

      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type In your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type In your phone number", title: "Phone Number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type In your email address", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type In a valid email address",
            title: "valid email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type In your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("password can not be less then 6 characters",
            title: "Name");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("success reg");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading
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
                          isObscure: true,
                          hintText: "Password",
                          icon: Icons.password_sharp),
                      Gap(
                        Dimensions.height20,
                      ),
                      //name
                      AppTextField(
                          textController: nameController,
                          hintText: "Name",
                          icon: Icons.person),
                      Gap(
                        Dimensions.height20,
                      ),
                      //phone
                      AppTextField(
                          textController: phoneController,
                          hintText: "Phone",
                          icon: Icons.phone),
                      Gap(
                        Dimensions.height20,
                      ),

                      GestureDetector(
                        onTap: () {
                          _registraion(_authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 20,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: BigText(
                              color: Colors.white,
                              text: "Sign Up",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                            ),
                          ),
                        ),
                      ),
                      Gap(Dimensions.height10),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                          text: "Have an Account already?",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                        ),
                      ),
                      Gap(Dimensions.screenHeight * 0.05),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font17,
                          ),
                          text: "sign up using one of the following methods",
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius30,
                                    backgroundImage: AssetImage(
                                        "assets/image/" + signUpImages[index]),
                                  ),
                                )),
                      )
                    ]),
                  )
                : Center(child: CustomLoader());
          },
        ));
  }
}
