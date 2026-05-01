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
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          InvitationThemeLauncher(
            heightAdjustment: kToolbarHeight,
            viewType: ViewType.example,
            invitationThemeId: extra.invitationThemeId,
            invitationId: '',
            invitationData: extra.invitationData,
            imagesRaw: null,
            brandProfile: extra.brandProfile,
            initialPage: extra.initialPage,
            useWrapper: extra.useWrapper,
            viewAsSinglePage: extra.viewAsSinglePage,
          ),
          Positioned(
            top: 10,
            left: 10,
            width: 50,
            height: 50,
            child: AppBarLeftAction(
              onTap: () => extra.viewAsSinglePage ? NavigationService.pop() : NavigationService.go('/themes-catalog'),
            ),
          ),
        ],
      ),
    );
  }
}
