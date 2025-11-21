import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ScanQrPortal extends StatelessWidget {
  const ScanQrPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralEffectsButton(
      onTap: () {
        ShowModal.bottomSheet(
          context,
          barrierColor: Colors.grey.shade700.withValues(alpha: .5),
          header: BottomSheetHeader(
            useHandleBar: true,
            handleColor: Colors.grey.shade500,
            action: HeaderAction(
              actionIcon: Icons.close_rounded,
              iconColor: Colors.grey.shade600,
              onTap: () => NavigationService.pop(),
            ),
          ),
          decoration: BottomSheetDecoration(
            color: ColorConverter.lighten(AppColor.primaryColor, 94),
            borderRadius: const .only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          contentBuilder: (_) => SizedBox(
            width: .maxFinite,
            height: 400,
            child: MobileScanner(
              fit: BoxFit.cover,
              onDetect: (capture) {
                final barcode = capture.barcodes.first;
                final String? code = barcode.rawValue;

                print(code);
              },
            ),
          ),
        );
      },
      padding: const .symmetric(horizontal: 20, vertical: 10),
      color: AppColor.primaryColor,
      splashColor: Colors.white,
      borderRadius: .circular(30),
      useInitialElevation: true,
      child: const Text(
        'Scan QR',
        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: .bold),
      ),
    );
  }
}
