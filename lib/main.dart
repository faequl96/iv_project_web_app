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
external JSPromise _jsUpdateSplashProgress(double initialPercent, double targetPercent, double minMs, double maxMs);

void main() async {
  usePathUrlStrategy();

  ApiUrl.set('https://in-vite.my.id');

  await StorageService.init();

  NavigationService.init(AppRouter.router);

  Dummys.initInvitationData();

  await _jsUpdateSplashProgress(80, 95, 50, 350).toDart;

  final paths = Uri.base.pathSegments;
  final path = paths.isNotEmpty ? paths[0] : '';

  if (path == 'theme-dev' || path == 'themes-catalog') {
    AppInit.preCacheDummmyImages(Dummys.invitationData);
    AppInit.preCacheAssetImages();
    if (path == 'themes-catalog') AppInit.getThemeCatalogSummaryImagePreviewSize();
  } else {
    final invitation = await AppInit.getInvitation();

    if (invitation != null) {
      AppInit.prefetchAudio(invitation);
      AppInit.preCacheImages(invitation);
      AppInit.preCacheAssetImages();

      AppRouter.initialInvitation = invitation;
    }
  }

  await Future.delayed(const Duration(seconds: 2));

  await _jsUpdateSplashProgress(95, 100, 150, 250).toDart;

  runApp(const App());
}
