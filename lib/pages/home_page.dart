import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return InvitationThemeLauncher(invitation: Invitation.create(themeId: 1, themeName: 'Try Theme'));
  }
}
