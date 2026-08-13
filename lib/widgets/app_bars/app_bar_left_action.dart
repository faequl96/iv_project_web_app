import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class const AppBarLeftAction({
  super.key,
  final IconData icon = Icons.arrow_back_ios_rounded,
  final Color? backgroundColor,
  final void Function()? onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuickButton(
      onTap: () => onTap?.call(),
      style: QuickButtonStyle(
        color: backgroundColor,
        splashColor: ColorUtil.lighten(AppColor.primaryColor),
        borderRadius: .circular(30),
      ),
      child: Icon(icon, size: 28, color: Colors.white),
    );
  }
}
