import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_app/core/di/app_bloc_providers.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...AppBlocProvider.dataProviders,
        ...AppBlocProvider.invitationThemeProviders,
        ...AppBlocProvider.globalProviders,
      ],
      child: const _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (_, locale) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        routerConfig: NavigationService.router,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(floatingLabelStyle: TextStyle(color: Colors.grey.shade300)),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.grey.shade100,
            selectionHandleColor: Colors.grey.shade100,
          ),
        ),
        locale: locale,
        supportedLocales: const [Locale('id', 'ID'), Locale('en', 'US')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
