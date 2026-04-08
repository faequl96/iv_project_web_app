// ignore_for_file: depend_on_referenced_packages

import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_app/app.dart';
import 'package:iv_project_web_app/core/app_init.dart';
import 'package:iv_project_web_app/dummys/dummys.dart';
import 'package:iv_project_web_app/routes/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

@JS('updateSplashProgress')
external JSPromise jsUpdateSplashProgress(double initialPercent, double targetPercent, double minMs, double maxMs);

void main() async {
  usePathUrlStrategy();

  ApiUrl.set('https://5da4-175-103-42-210.ngrok-free.app');

  await StorageService.init();

  NavigationService.init(AppRouter.router);

  Dummys.initInvitationData();

  jsUpdateSplashProgress(60, 95, 50, 350);

  final paths = Uri.base.pathSegments;
  final path = paths.isNotEmpty ? paths[0] : '';

  if (path == 'theme-dev') {
    AppInit.preCacheDummmyImages(Dummys.invitationData);
    AppInit.preCacheAssetImages();
  } else {
    final invitation = await AppInit.getInvitation();

    if (invitation != null) {
      AppInit.prefetchAudio(invitation);
      AppInit.preCacheImages(invitation);

      AppRouter.initialInvitation = invitation;
    }
  }

  await Future.delayed(const Duration(seconds: 2));

  await jsUpdateSplashProgress(95, 100, 150, 250).toDart;

  runApp(const App());
}
