import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_web_app/models/extras.dart';

class InvitationExampleViewerPage extends StatelessWidget {
  const InvitationExampleViewerPage({super.key, required this.extra});

  final InvitationExampleViewerExtra extra;

  @override
  Widget build(BuildContext context) {
    return InvitationThemeLauncher(
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
    );
  }
}
