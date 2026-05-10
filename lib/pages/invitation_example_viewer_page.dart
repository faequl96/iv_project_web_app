import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_web_app/models/extras.dart';
import 'package:iv_project_web_app/widgets/app_bars/app_bar_left_action.dart';

class InvitationExampleViewerPage extends StatelessWidget {
  const InvitationExampleViewerPage({super.key, required this.extra});

  final InvitationExampleViewerExtra extra;

  @override
  Widget build(BuildContext context) {
    if (extra.viewAsSinglePage) {
      return ColoredBox(
        color: Colors.black,
        child: Stack(
          children: [
            InvitationThemeAsSinglePageLauncher(
              heightAdjustment: 0,
              invitationThemeId: extra.invitationThemeId,
              invitationData: extra.invitationData,
              brandProfile: extra.brandProfile,
              initialPage: extra.initialPage,
              useWrapper: extra.useWrapper,
            ),
            Positioned(
              top: 10,
              left: 10,
              width: 50,
              height: 50,
              child: AppBarLeftAction(backgroundColor: Colors.white.withValues(alpha: .4), onTap: () => NavigationService.pop()),
            ),
          ],
        ),
      );
    }

    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          InvitationThemeLauncher(
            heightAdjustment: 0,
            viewType: ViewType.example,
            invitationThemeId: extra.invitationThemeId,
            invitationId: '',
            invitationData: extra.invitationData,
            imagesRaw: null,
            brandProfile: extra.brandProfile,
          ),
          Positioned(
            top: 10,
            left: 10,
            width: 50,
            height: 50,
            child: AppBarLeftAction(
              backgroundColor: Colors.white.withValues(alpha: .4),
              onTap: () => NavigationService.go('/themes-catalog'),
            ),
          ),
        ],
      ),
    );
  }
}
