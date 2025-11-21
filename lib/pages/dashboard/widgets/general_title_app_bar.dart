import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iv_project_core/iv_project_core.dart';

class GeneralTitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralTitleAppBar({super.key, required this.title, this.leftAction, this.rightAction})
    : preferredSize = const Size.fromHeight(kToolbarHeight);

  final Widget title;
  final Widget? leftAction;
  final Widget? rightAction;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    Widget? leftActionValue;
    if (leftAction != null) {
      leftActionValue = leftAction!;
    }

    List<Widget>? rightActionValue;
    if (rightAction != null) {
      rightActionValue = [rightAction!];
    }

    return SizedBox(
      height: kToolbarHeight,
      child: AppBar(
        leading: leftActionValue,
        titleSpacing: 0,
        title: title,
        actions: rightActionValue,
        elevation: 1,
        backgroundColor: AppColor.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      ),
    );
  }
}
