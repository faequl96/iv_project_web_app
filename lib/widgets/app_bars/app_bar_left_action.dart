import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class AppBarLeftAction extends StatelessWidget {
  const AppBarLeftAction({super.key, this.icon = Icons.arrow_back_ios_rounded, this.onTap});

  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GeneralEffectsButton(
      onTap: () => onTap?.call(),
      splashColor: ColorConverter.lighten(AppColor.primaryColor),
      borderRadius: .circular(30),
      child: Icon(icon, size: 28, color: Colors.white),
    );
  }
}
