import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class const Page({super.key, final PreferredSizeWidget? appBar, required final Widget content})
    extends StatelessWidget {
  @override
  Widget build(context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const .linear(1)),
      child: Scaffold(
        body: Stack(
          children: [
            if (appBar != null)
              SizedBox(
                height: .infinity,
                width: .infinity,
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    Flexible(child: StickyOverlayWrapper(child: content)),
                  ],
                ),
              )
            else
              StickyOverlayWrapper(child: content),

            if (appBar != null) SizedBox(height: kToolbarHeight, child: appBar),
          ],
        ),
        backgroundColor: ColorUtil.lighten(AppColor.primaryColor, 94),
      ),
    );
  }
}
