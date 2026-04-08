import 'package:flutter/material.dart' hide Page;
import 'package:go_router/go_router.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/pages/home_page.dart';
import 'package:iv_project_web_app/pages/page.dart';
import 'package:iv_project_web_app/pages/theme_dev_page.dart';

class AppRouter {
  const AppRouter._();

  static InvitationResponse? _initialInvitation;

  static set initialInvitation(InvitationResponse? invitation) => _initialInvitation = invitation;

  static GoRouter get router => GoRouter(
    navigatorKey: GlobalContextService.navigatorKey,
    routes: [
      _pageBuilder('/', page: (_) => HomePage(invitation: _initialInvitation)),
      _pageBuilder('/theme-dev', page: (_) => const ThemeDevPage()),
    ],
  );

  static GoRoute _pageBuilder(String routePath, {required Widget Function(GoRouterState state) page}) {
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
}
