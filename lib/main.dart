// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_app/app.dart';
import 'package:iv_project_web_app/routes/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  usePathUrlStrategy();

  print('test deploy 3');

  ApiUrl.set('https://e5d3-110-137-193-158.ngrok-free.app');

  NavigationService.init(router);

  await StorageService.init();

  runApp(const App());
}
