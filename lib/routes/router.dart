import 'package:flutter/material.dart' hide Page;
import 'package:go_router/go_router.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_app/pages/home_page.dart';
import 'package:iv_project_web_app/pages/page.dart';

final router = GoRouter(
  navigatorKey: GlobalContextService.navigatorKey,
  routes: [
    _pageBuilder(
      '/',
      page: (state) {
        final id = state.uri.queryParameters['id'] ?? Uri.base.queryParameters['id'];
        if (id == null) return const Center(child: Text('Link tidak menyertakan ID'));
        return HomePage(invitationId: id);
      },
    ),
  ],
);

GoRoute _pageBuilder(String routePath, {required Widget Function(GoRouterState state) page}) {
  return GoRoute(
    path: routePath,
    pageBuilder: (_, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (_, _, _, child) => child,
        child: Page(content: page(state)),
      );
    },
  );
}
