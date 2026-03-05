import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/dummys/dummys.dart';

class ThemeDevPage extends StatefulWidget {
  const ThemeDevPage({super.key});

  @override
  State<ThemeDevPage> createState() => _ThemeDevPageState();
}

class _ThemeDevPageState extends State<ThemeDevPage> {
  @override
  Widget build(BuildContext context) {
    return InvitationThemeLauncher(
      viewType: ViewType.example,
      invitationThemeId: 2,
      invitationId: '',
      invitationData: Dummys.invitationData,
      brandProfile: const BrandProfileResponse(name: '', email: ''),
    );
  }
}
