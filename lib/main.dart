// ignore_for_file: depend_on_referenced_packages

import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_app/app.dart';
import 'package:iv_project_web_app/dummys/dummys.dart';
import 'package:iv_project_web_app/routes/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

@JS('removeSplash')
external void jsRemoveSplash();

void main() async {
  usePathUrlStrategy();

  ApiUrl.set('https://5da4-175-103-42-210.ngrok-free.app');

  NavigationService.init(router);

  await StorageService.init();

  Dummys.initInvitationData();

  await fetchYourDataFromApi();
  // await precacheImage(NetworkImage(url), context);

  jsRemoveSplash();

  runApp(const App());
}

Future<void> fetchYourDataFromApi() async {
  await Future.delayed(const Duration(seconds: 4));
}
