import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:iv_project_core/iv_project_core.dart';

import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/dummys/dummys.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _invitationId;
  InvitationResponse? _invitation;

  Future<void> _getInvitationById(String id) async {
    final url = Uri.parse('https://6bf854fbdf4a.ngrok-free.app/api/v1/invitation/id/$id');
    _invitation = InvitationResponse(
      id: '123',
      remainingEditCount: 1,
      transactionId: '',
      status: InvitationStatusType.active,
      invitationThemeId: 1,
      invitationThemeName: 'Elegant Black And White Glass',
      brandProfile: const BrandProfileResponse(
        id: 1,
        name: 'In Vite',
        email: 'faequl96@gmail.com',
        phone: '085640933136',
        instagram: 'faequl96',
        address: 'Perum. Puri Bintaro Hijau, Blok C2 No.6, Kel. Pondok Aren, Kec. Pondok Aren, Kota Tangerang Selatan',
      ),
      invitationData: Dummys.invitationData,
    );
    try {
      final response = await http.get(url, headers: {'ngrok-skip-browser-warning': 'true'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _invitation = InvitationResponse.fromJson(data['data']);
        setState(() {});
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();

    _invitationId = Uri.base.queryParameters['id'];
    if (_invitationId != null) _getInvitationById(_invitationId!);

    if (_invitation != null) {
      context.read<LocaleCubit>().set(
        _invitation!.invitationData.general.lang == LangType.en ? const Locale('en', 'US') : const Locale('id', 'ID'),
        reloadLangAssets: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_invitationId == null) return const Center(child: Text('Link tidak menyertakan ID'));
    if (_invitation == null) {
      return const Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 24 / 5.2, color: AppColor.primaryColor),
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
