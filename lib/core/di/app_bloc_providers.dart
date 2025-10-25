import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

class AppBlocProvider {
  AppBlocProvider._();

  static final invitationThemeProviders = <BlocProvider>[
    BlocProvider<InvitationThemeCoreCubit>(create: (_) => InvitationThemeCoreCubit()),
  ];
}
