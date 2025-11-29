// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_app/app.dart';
import 'package:iv_project_web_app/routes/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();

  ApiConfig.set('https://6538439dc155.ngrok-free.app');

  NavigationService.init(router);

  runApp(const App());
}
