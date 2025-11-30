import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:iv_project_core/iv_project_core.dart';

import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_data/iv_project_web_data.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  bool _isContainsErrorGetInvitation = false;
  bool _isContainsErrorGetInvitedGuest = false;

  String? _invitationId;
  String? _invitedGuestId;

  InvitationResponse? _invitation;

  late final LocaleCubit _localeCubit;
  late final InvitedGuestCubit _invitedGuestCubit;

  Future<void> _getInvitationById(String id) async {
    _isContainsErrorGetInvitation = false;

    final url = Uri.parse('${ApiConfig.url}/invitation/id/$id');
    try {
      final response = await http.get(url, headers: {'ngrok-skip-browser-warning': 'true'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _invitation = InvitationResponse.fromJson(data['data']);

        if (_invitation != null) {
          _localeCubit.set(
            _invitation!.invitationData.general.lang == LangType.en ? const Locale('en', 'US') : const Locale('id', 'ID'),
            reloadLangAssets: false,
          );
        }
      }
    } catch (_) {
      _isContainsErrorGetInvitation = true;
    }
  }

  @override
  void initState() {
    super.initState();

    _localeCubit = context.read<LocaleCubit>();
    _invitedGuestCubit = context.read<InvitedGuestCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final queryParameters = Uri.base.queryParameters;

      _invitationId = queryParameters['id'];
      if (_invitationId != null) await _getInvitationById(_invitationId!);

      _invitedGuestId = queryParameters['to'];
      if (_invitedGuestId != null) {
        _isContainsErrorGetInvitedGuest = !(await _invitedGuestCubit.getById(_invitedGuestId!));
      }

      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return ColoredBox(
        color: ColorConverter.lighten(AppColor.primaryColor, 94),
        child: const Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 24 / 5.2, color: AppColor.primaryColor),
          ),
        ),
      );
    }

    final size = MediaQuery.of(context).size;

    if (_isContainsErrorGetInvitation || _isContainsErrorGetInvitedGuest) {
      return SizedBox(
        height: size.height,
        child: RetryWidget(
          errorMessage: _localeCubit.state.languageCode == 'id'
              ? 'Oops. Gagal memuat undangan.'
              : 'Oops. Failed to fetch invitation',
          onRetry: () async {
            setState(() => _isLoading = true);
            if (_isContainsErrorGetInvitation) await _getInvitationById(_invitationId!);
            if (_isContainsErrorGetInvitedGuest) {
              _isContainsErrorGetInvitedGuest = !(await _invitedGuestCubit.getById(_invitedGuestId!));
            }
            setState(() => _isLoading = false);
          },
        ),
      );
    }

    if (_invitationId == null || _invitation == null) {
      return SizedBox(
        height: size.height,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Spacer(),
            Text(
              _localeCubit.state.languageCode == 'id' ? 'Undangan tidak ditemukan' : 'Invitation not found.',
              style: AppFonts.nunito(fontSize: 18, fontWeight: .bold),
            ),
            const Spacer(),
            Text(
              _localeCubit.state.languageCode == 'id' ? 'Ingin membuat undanganmu sendiri?' : 'Want to make your own invitation?',
              style: AppFonts.nunito(fontSize: 16, fontWeight: .w500),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  _localeCubit.state.languageCode == 'id' ? 'Unduh Aplikasi' : 'Download',
                  style: AppFonts.nunito(fontSize: 16, fontWeight: .bold),
                ),
                const SizedBox(width: 6),
                Image.asset(
                  'assets/logos/in_vite_logo.png',
                  height: 20,
                  package: 'iv_project_invitation_theme',
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(width: 6),
                if (_localeCubit.state.languageCode == 'en') Text('App', style: AppFonts.nunito(fontSize: 16, fontWeight: .bold)),
              ],
            ),
            GeneralEffectsButton(
              onTap: () {},
              height: 60,
              child: Image.asset('assets/get_it_on_google_play.png', height: 50, fit: BoxFit.fitHeight),
            ),
            const SizedBox(height: 44),
          ],
        ),
      );
    }

    return InvitationThemeLauncher(
      previewType: ThemePreviewType.fromResponse,
      invitationThemeId: _invitation!.invitationThemeId,
      invitationId: _invitation!.id,
      invitationData: _invitation!.invitationData,
      brandProfile: _invitation!.brandProfile,
    );
  }
}
