import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_web_app/core/di/app_bloc_providers.dart';

class const App({super.key}) extends StatelessWidget {
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

class const _App() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (_, locale) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MyCustomScrollBehavior(),
        routerConfig: NavigationService.router,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle: TextStyle(color: Colors.grey.shade300),
          ),
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

class const MyCustomScrollBehavior() extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}

class const InitAppState({super.key, required final Widget page}) extends StatefulWidget {
  static bool _isInitializing = true;

  @override
  State<InitAppState> createState() => _InitAppStateState();
}

class _InitAppStateState() extends State<InitAppState> with WidgetsBindingObserver {
  void _setSize() {
    AppSize.set(MediaQuery.of(GlobalContextService.value));
    ThemeAppHelpers.setSize(context.read<InvitationThemeCoreCubit>(), 0);
  }

  void _initSync() {
    _setSize();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if (InitAppState._isInitializing) {
      _initSync();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (InitAppState._isInitializing) {
      _initSync();

      InitAppState._isInitializing = false;
    }
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    _setSize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.page;
}
