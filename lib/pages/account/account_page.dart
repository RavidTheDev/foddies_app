import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foddies_app/base/custom_loader.dart';
import 'package:foddies_app/controllers/auth_controller.dart';
import 'package:foddies_app/controllers/cart_controller.dart';
import 'package:foddies_app/controllers/location_controller.dart';
import 'package:foddies_app/routes/route_helper.dart';
import 'package:foddies_app/utils/colors.dart';
import 'package:foddies_app/utils/dimensions.dart';
import 'package:foddies_app/widgets/account_widget.dart';
import 'package:foddies_app/widgets/app_icon.dart';
import 'package:foddies_app/widgets/big_text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Center(
            child: BigText(
              text: "Profile",
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(children: [
                          //Profile
                          AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height45 * 2,
                              size: Dimensions.height15 * 10),
                          Gap(Dimensions.height30),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  //Name
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.name,
                                    ),
                                  ),
                                  Gap(Dimensions.height30),
                                  //Phone
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.phone,
                                    ),
                                  ),
                                  Gap(Dimensions.height30),
                                  //Email
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.email,
                                    ),
                                  ),
                                  Gap(Dimensions.height30),
                                  //Address
                                  GetBuilder<LocationController>(
                                      builder: (locationController) {
                                    if (_userLoggedIn &&
                                        locationController
                                            .addressList.isEmpty) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.offNamed(
                                              RouteHelper.getAddressPage());
                                        },
                                        child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.yellowColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: "fill in your address",
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.offNamed(
                                              RouteHelper.getAddressPage());
                                        },
                                        child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.yellowColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: "your address",
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                  Gap(Dimensions.height30),
                                  //message
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.message_outlined,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: "Message",
                                    ),
                                  ),
                                  Gap(Dimensions.height30),
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.find<LocationController>()
                                            .clearAddressList();
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      } else {
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      }
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout_outlined,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: "Log Out",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                      )
                    : CustomLoader())
                : Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 11,
                            margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/signintocontinue.png"),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getSignInPage());
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: Dimensions.height20 * 5,
                              margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                              ),
                              child: Center(
                                child: BigText(
                                  text: "Sign In",
                                  color: Colors.white,
                                  size: Dimensions.font26,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ));
  }
}
