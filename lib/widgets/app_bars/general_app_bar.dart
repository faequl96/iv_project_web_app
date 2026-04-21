import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralAppBar({
    super.key,
    required this.title,
    this.backgroundColor = AppColor.primaryColor,
    this.elevation = 1,
    this.extraTitle,
    this.leftAction,
    this.rightAction,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final String title;
  final Color backgroundColor;
  final double elevation;
  final String? extraTitle;
  final Widget? leftAction;
  final Widget? rightAction;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    Widget? leftActionValue;
    if (leftAction != null) {
      leftActionValue = Theme(
        data: ThemeData(textTheme: AppTextThemes.nunito(), useMaterial3: true),
        child: leftAction!,
      );
    }

    List<Widget>? rightActionValue;
    if (rightAction != null) {
      rightActionValue = [
        Theme(
          data: ThemeData(textTheme: AppTextThemes.nunito(), useMaterial3: true),
          child: rightAction!,
        ),
      ];
    }

    return Theme(
      data: ThemeData(textTheme: AppTextThemes.nunito(), useMaterial3: false),
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
                    return RunningText(text: '${AppLocalization.translate(title)} - $extraTitle', constraints: constraints);
                  },
                );
              }
              return Text(
                AppLocalization.translate(title),
                style: const TextStyle(fontSize: 16, fontWeight: .bold, color: Colors.white),
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
