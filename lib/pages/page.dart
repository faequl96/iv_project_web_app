import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class Page extends StatelessWidget {
  const Page({super.key, this.appBar, required this.content});

  final PreferredSizeWidget? appBar;
  final Widget content;

  @override
  Widget build(context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        body: Stack(
          children: [
            if (appBar != null)
              SizedBox(
                height: .maxFinite,
                width: .maxFinite,
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    Flexible(child: Overlay.wrap(child: content)),
                  ],
                ),
              )
            else
              Overlay.wrap(child: content),

            SizedBox(height: kToolbarHeight, child: appBar ?? const SizedBox.shrink()),
          ],
        ),
        backgroundColor: ColorConverter.lighten(AppColor.primaryColor, 94),
      ),
    );
  }
}
