import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/dummys/dummys.dart';

class ThemeDevPage extends StatelessWidget {
  const ThemeDevPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = int.tryParse(Uri.base.queryParameters['id'] ?? '') ?? 1;

    return InvitationThemeLauncher(
      viewType: ViewType.example,
      invitationThemeId: id,
      invitationId: '',
      invitationData: Dummys.invitationData,
      brandProfile: const BrandProfileResponse(name: '', email: ''),
    );
  }
}
