import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';

class const GeneralAppBar({
  super.key,
  required final String title,
  final Color backgroundColor = AppColor.primaryColor,
  final double elevation = 1,
  final String? extraTitle,
  final Widget? leftAction,
  final Widget? rightAction,
}) extends StatelessWidget implements PreferredSizeWidget {
  this : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    Widget? leftActionValue;
    if (leftAction != null) {
      leftActionValue = Theme(
        data: ThemeData(textTheme: AppTextThemes.inter(), useMaterial3: true),
        child: leftAction!,
      );
    }

    List<Widget>? rightActionValue;
    if (rightAction != null) {
      rightActionValue = [
        Theme(
          data: ThemeData(textTheme: AppTextThemes.inter(), useMaterial3: true),
          child: rightAction!,
        ),
      ];
    }

    return Theme(
      data: ThemeData(textTheme: AppTextThemes.inter(), useMaterial3: false),
      child: SizedBox(
        height: kToolbarHeight,
        child: AppBar(
          leading: leftActionValue,
          titleSpacing: 0,
          title: BlocBuilder<LocaleCubit, Locale>(
            builder: (_, _) {
              if (extraTitle != null) {
                return LayoutBuilder(
                  builder: (_, constraints) {
                    return RunningText(
                      text: '${AppLocalization.translate(title)} - $extraTitle',
                      constraints: constraints,
                    );
                  },
                );
              }
              return Text(
                AppLocalization.translate(title),
                style: const TextStyle(fontSize: 16, fontWeight: .w600, color: Colors.white),
              );
            },
          ),
          actions: rightActionValue,
          elevation: elevation,
          backgroundColor: backgroundColor,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: .light),
        ),
      ),
    );
  }
}
