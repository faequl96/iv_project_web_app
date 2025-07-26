import 'package:flutter/material.dart' hide Page;
import 'package:go_router/go_router.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_app/pages/home_page.dart';
import 'package:iv_project_web_app/pages/page.dart';

final router = GoRouter(
  navigatorKey: GlobalContextService.navigatorKey,
  initialLocation: '/',
  routes: [_pageBuilder('/', page: const HomePage())],
);

GoRoute _pageBuilder(String routePath, {required Widget page}) {
  return GoRoute(
    path: routePath,
    pageBuilder: (_, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (_, _, _, child) => child,
        child: Page(content: page),
      );
    },
  );
}
