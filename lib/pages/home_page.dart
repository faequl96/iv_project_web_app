import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iv_project_core/iv_project_core.dart';

import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.invitationId});

  final String invitationId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InvitationResponse? _invitation;

  Future<void> _getInvitationById(String id) async {
    final url = Uri.parse('https://ac8ec8576ccf.ngrok-free.app/api/v1/invitation/id/$id');
    try {
      final response = await http.get(url);
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

    _getInvitationById(widget.invitationId);
  }

  @override
  Widget build(BuildContext context) {
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
      invitationData: _invitation!.invitationData,
    );
  }
}
