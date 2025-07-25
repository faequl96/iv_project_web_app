import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_app/core/di/app_bloc_providers.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [...AppBlocProvider.invitationThemeProviders], child: const _App());
  }
}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: NavigationService.router,
      theme: ThemeData(
        textTheme: GoogleFonts.ibmPlexSansTextTheme(),
        inputDecorationTheme: const InputDecorationTheme(floatingLabelStyle: TextStyle(color: AppColor.primaryColor)),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColor.primaryColor,
          selectionHandleColor: AppColor.primaryColor,
        ),
      ),
    );
  }
}
