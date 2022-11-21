import 'package:flutter/material.dart';
import 'package:foddies_app/utils/dimensions.dart';
import 'package:foddies_app/widgets/small_text.dart';
import 'package:gap/gap.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        Gap(5),
        SmallText(
          text: text,
        ),
      ],
    );
  }
}
