import 'package:flutter/material.dart' hide Page;
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/app.dart';
import 'package:iv_project_web_app/core/helpers/extra_helper.dart';
import 'package:iv_project_web_app/pages/home_page.dart';
import 'package:iv_project_web_app/pages/invitation_example_viewer_page.dart';
import 'package:iv_project_web_app/pages/page.dart';
import 'package:iv_project_web_app/pages/theme_dev_page.dart';
import 'package:iv_project_web_app/pages/themes_catalog/themes_catalog_page.dart';
import 'package:iv_project_web_app/widgets/app_bars/app_bar_left_action.dart';
import 'package:iv_project_web_app/widgets/app_bars/general_app_bar.dart';

class AppRouter {
  const AppRouter._();

  static InvitationResponse? _initialInvitation;

  static set initialInvitation(InvitationResponse? invitation) => _initialInvitation = invitation;

  static GoRouter get router => GoRouter(
    navigatorKey: GlobalContextService.navigatorKey,
    routes: [
      _pageBuilder('/', page: (_) => HomePage(invitation: _initialInvitation)),
      _pageBuilder('/theme-dev', page: (_) => const ThemeDevPage()),
      _pageBuilder(
        '/themes-catalog',
        page: (_) => const ThemesCatalogPage(),
        appBar: (extra) {
          return GeneralAppBar(
            title: 'Catalog Tema Undangan',
            backgroundColor: AppColor.primaryColor,
            leftAction: AppBarLeftAction(onTap: () {}, icon: Icons.style),
          );
        },
      ),
      _pageBuilder(
        '/invitation-example-viewer',
        page: (extra) {
          final extraValue = ExtraHelper.receiveInvitationExampleViewerExtra(extra);
          if (extraValue == null) return const SizedBox.shrink();
          return InvitationExampleViewerPage(extra: extraValue);
        },
      ),
    ],
  );

  static GoRoute _pageBuilder(
    String routePath, {
    PreferredSizeWidget Function(Object? extra)? appBar,
    required Widget Function(Object? extra) page,
  }) {
    return GoRoute(
      path: routePath,
      pageBuilder: (_, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: (_, _, _, child) => child,
          child: InitAppState(
            page: Page(appBar: appBar?.call(state.extra), content: page(state.extra)),
          ),
        );
      },
    );
  }
}
