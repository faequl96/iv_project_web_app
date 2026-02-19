// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_app/app.dart';
import 'package:iv_project_web_app/routes/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  usePathUrlStrategy();

  print('test deploy 7');
  final buildCommand = 'flutter/bin/flutter --version && flutter/bin/flutter build web --wasm --release';
  final installCommand = 'git clone https://github.com/flutter/flutter.git -b 3.38.9 --depth 1';

  ApiUrl.set('https://e5d3-110-137-193-158.ngrok-free.app');

  NavigationService.init(router);

  await StorageService.init();

  runApp(const App());
}
