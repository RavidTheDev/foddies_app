import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foddies_app/controllers/auth_controller.dart';
import 'package:foddies_app/utils/colors.dart';
import 'package:foddies_app/utils/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("loading stat " + Get.find<AuthController>().isLoading.toString());
    return Container(
      height: Dimensions.height20 * 5,
      width: Dimensions.width20 * 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20 * 5 / 2),
          color: AppColors.mainColor),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
