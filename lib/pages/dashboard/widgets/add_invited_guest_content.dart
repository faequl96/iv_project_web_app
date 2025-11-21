import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class AddInvitedGuestContent extends StatefulWidget {
  const AddInvitedGuestContent({super.key});

  @override
  State<AddInvitedGuestContent> createState() => _AddInvitedGuestContentState();
}

class _AddInvitedGuestContentState extends State<AddInvitedGuestContent> {
  String? _invitationId;

  late final InvitedGuestCubit _invitedGuestCubit;

  Future<void> _downloadExcelAsset() async {
    final data = await rootBundle.load('assets/templates/formulir_tamu_undangan.xlsx');
    final bytes = data.buffer.asUint8List();
    await FileSaver.instance.saveFile(name: 'formulir_tamu_undangan', bytes: bytes, mimeType: MimeType.microsoftExcel);
  }

  Future<PlatformFile?> _pickExcelFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx', 'xls'], withData: true);
    if (result == null) return null;
    return result.files.first;
  }

  Future<void> _upsertInvitedGuests() async {
    if (_invitationId == null) return;

    final file = await _pickExcelFile();
    final fileBytes = file?.bytes;
    if (fileBytes == null) {
      GeneralDialog.showValidateStateError('Tidak ada file yang dipilih', durationInSeconds: 5);
      return;
    }

    final excel = Excel.decodeBytes(fileBytes);

    final sheet = excel.tables.keys.first;
    final rows = excel.tables[sheet]!.rows;

    List<CreateInvitedGuestRequest> invitedGuestRequests = [];

    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];
      if (row.isEmpty) continue;

      final name = row[0]?.value?.toString();
      final instance = row[1]?.value?.toString() ?? '';
      final whatsapp = row[2]?.value?.toString();
      final souvenir = row[3]?.value?.toString();

      if (name == null ||
          whatsapp == null ||
          name.contains('cth') ||
          instance.contains('cth') ||
          whatsapp.contains('cth') ||
          (souvenir ?? '').contains('cth')) {
        continue;
      }

      invitedGuestRequests.add(
        CreateInvitedGuestRequest(
          invitationId: _invitationId!,
          name: name,
          nameInstance: '${name.replaceAll(' ', '-')}_${instance.replaceAll(' ', '-')}',
          phone: whatsapp,
          souvenir: souvenir,
        ),
      );
    }

    await _invitedGuestCubit.upsert(BulkInvitedGuestRequest(invitedGuests: invitedGuestRequests));
  }

  @override
  void initState() {
    super.initState();

    _invitationId = Uri.base.queryParameters['id'];

    _invitedGuestCubit = context.read<InvitedGuestCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(16),
      child: Column(
        mainAxisSize: .min,
        children: [
          const Text(
            'Silahkan unduh formulir tamu undangan dibawah ini. Kemudian lakukan pengisian daftar tamu undangan pada formulir yang telah diunduh',
            style: TextStyle(fontSize: 15),
            textAlign: .center,
          ),
          const SizedBox(height: 12),
          GeneralEffectsButton(
            onTap: _downloadExcelAsset,
            padding: const .symmetric(horizontal: 24, vertical: 10),
            color: Colors.white,
            splashColor: Colors.white,
            borderRadius: .circular(30),
            border: .all(color: AppColor.primaryColor, width: 2),
            useInitialElevation: true,
            child: const Row(
              mainAxisSize: .min,
              children: [
                Text(
                  'Unduh Formulir',
                  style: TextStyle(color: AppColor.primaryColor, fontSize: 15, fontWeight: .bold),
                ),
                SizedBox(width: 6),
                Icon(Icons.download, color: AppColor.primaryColor),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Jika telah mengisi, kemudian silahkan import formulir tersebut dengan tombol di bawah ini',
            style: TextStyle(fontSize: 15),
            textAlign: .center,
          ),
          const SizedBox(height: 20),
          BlocSelector<InvitedGuestCubit, InvitedGuestState, bool>(
            selector: (state) => state.isLoadingUpsert,
            builder: (context, isLoading) {
              return GeneralEffectsButton(
                onTap: _upsertInvitedGuests,
                isDisabled: isLoading,
                width: .maxFinite,
                padding: const .symmetric(vertical: 14),
                color: AppColor.primaryColor,
                splashColor: Colors.white,
                borderRadius: .circular(30),
                useInitialElevation: true,
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    if (isLoading) ...[SharedPersonalize.loadingWidget(size: 20, color: Colors.white), const SizedBox(width: 10)],
                    const Text(
                      'Import dari Excel',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: .bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
