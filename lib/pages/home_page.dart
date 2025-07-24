import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return const SizedBox.shrink();
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Center(
        child: ColoredBox(
          color: Colors.red,
          child: Image.asset(
            // 'https://iv-project-web-app.vercel.app/assets/packages/iv_project_invitation_theme/assets/dummys/try_theme_cover_image.jpg',
            'assets/dummys/try_theme_cover_image.jpg',
            // package: 'iv_project_invitation_theme',
            height: 300,
            width: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    // return InvitationThemeLauncher(invitation: Invitation.create(themeId: 1, themeName: 'Try Theme'));
  }
}
