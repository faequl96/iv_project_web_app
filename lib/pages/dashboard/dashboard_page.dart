import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

import 'package:iv_project_model/iv_project_model.dart';
// import 'package:iv_project_web_app/dummys/dummys.dart';
import 'package:iv_project_web_app/pages/dashboard/widgets/add_invited_guest_portal.dart';
import 'package:iv_project_web_app/pages/dashboard/widgets/edit_message_portal.dart';
import 'package:iv_project_web_app/pages/dashboard/widgets/general_title_app_bar.dart';
import 'package:iv_project_web_app/pages/dashboard/widgets/invited_guests_presentation.dart';
import 'package:iv_project_web_app/pages/dashboard/widgets/scan_qr_portal.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
// import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _messageController = TextEditingController();

  final _messages = [
    'Kepada Yth. \n{nama_tamu} \n\nDengan memohon rahmat dan ridha Tuhan Yang Maha Esa, kami bermaksud mengundang Anda untuk hadir pada hari bahagia kami. Pada momen istimewa ini, kami berharap dapat berbagi kebahagiaan dengan orang-orang terdekat yang memiliki tempat khusus dalam perjalanan hidup kami. \n\nDetail acara dapat Anda lihat melalui undangan digital berikut: \n{link_undangan} \n\nKehadiran {nama_tamu} akan melengkapi kebahagiaan kami dan menjadi doa restu yang sangat berarti. \n\nDengan penuh rasa syukur, \n{mempelai_wanita} & {mempelai_pria}',
    'Kepada Yth. \n{nama_tamu} \n\nDengan penuh rasa syukur dan kebahagiaan, kami mengundang Anda untuk menghadiri hari bersejarah dalam hidup kami. Setelah melalui perjalanan panjang penuh doa, harapan, dan ikhtiar, akhirnya kami akan memulai babak baru sebagai pasangan suami istri. \n\nAkan menjadi kebahagiaan tersendiri bagi kami apabila Anda, dapat hadir dan menyaksikan momen sakral ini. Kehadiran {nama_tamu} akan melengkapi kebahagiaan kami dan menjadi doa restu yang sangat berarti. \n\nDetail acara dapat Anda lihat melalui undangan digital berikut: \n{link_undangan} \n\nDengan penuh rasa syukur, \n{mempelai_wanita} & {mempelai_pria}',
    'Kepada Yth. \n{nama_tamu} \n\nDengan penuh kasih dan harapan, kami mengundang Anda untuk menjadi saksi awal kisah baru kami. Pada hari ketika dua hati dipersatukan dalam ikatan suci. \n\nAkan menjadi kebahagiaan tersendiri bagi kami apabila Anda, yang telah menjadi bagian dari cerita dan perjalanan kami, dapat hadir dan menyaksikan momen sakral ini. \n\nDetail acara dapat Anda lihat melalui undangan digital berikut: \n{link_undangan} \n\nKehadiran {nama_tamu} akan melengkapi kebahagiaan kami dan menjadi doa restu yang sangat berarti. \n\nDengan penuh rasa syukur, \n{mempelai_wanita} & {mempelai_pria}',
  ];

  bool _isLoading = false;

  String? _invitationId;
  InvitationResponse? _invitation;

  late final LocaleCubit _localeCubit;
  late final InvitedGuestCubit _invitedGuestCubit;

  Future<void> _getInvitationById(String id) async {
    _isLoading = true;
    _invitedGuestCubit.state.copyWith(isLoadingGetsByInvitationId: true).emitState();

    final url = Uri.parse('https://9dae0f172e7c.ngrok-free.app/api/v1/invitation/id/$id');
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

      _isLoading = false;
      setState(() {});
    } catch (_) {
      _isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    _localeCubit = context.read<LocaleCubit>();
    _invitedGuestCubit = context.read<InvitedGuestCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _invitationId = Uri.base.queryParameters['id'];
      if (_invitationId != null) {
        await _getInvitationById(_invitationId!);
        await Future.delayed(const Duration(seconds: 3));
        await _invitedGuestCubit.getsByInvitationId(_invitationId!);
      }
      _messageController.text = _messages[2];
    });
  }

  @override
  void dispose() {
    _messageController.dispose();

    super.dispose();
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

    if (_invitation == null) return const SizedBox.shrink();

    final size = MediaQuery.of(context).size;

    final invitationData = _invitation!.invitationData;

    return Theme(
      data: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(floatingLabelStyle: TextStyle(color: AppColor.primaryColor)),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColor.primaryColor,
          selectionHandleColor: AppColor.primaryColor,
        ),
      ),
      child: Stack(
        alignment: .topCenter,
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: ColoredBox(
              color: ColorConverter.lighten(AppColor.primaryColor, 94),
              child: Column(
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Flexible(
                    child: InvitedGuestsPresentation(
                      controller: _messageController,
                      invitationId: _invitationId!,
                      brideName: _invitation!.invitationData.bride.nickname,
                      groomName: _invitation!.invitationData.groom.nickname,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GeneralTitleAppBar(
            title: LayoutBuilder(
              builder: (_, constraints) => RunningText(
                text: 'Dashboard Tamu Undangan Pernikahan - ${invitationData.bride.nickname} & ${invitationData.groom.nickname}',
                constraints: constraints,
              ),
            ),
            leftAction: const Text('tes'),
            rightAction: const ScanQrPortal(),
          ),
          Positioned(
            bottom: 20,
            child: Row(
              children: [
                const AddInvitedGuestPortal(),
                const SizedBox(width: 10),
                EditMessagePortal(controller: _messageController, messages: _messages),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
