import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ScanQrPortal extends StatelessWidget {
  const ScanQrPortal({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const .only(left: 4, right: 14),
      child: GeneralEffectsButton(
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
              borderRadius: const .only(topLeft: .circular(20), topRight: .circular(20)),
            ),
            contentBuilder: (_) => Padding(
              padding: const .only(left: 14, right: 14, bottom: 20),
              child: SizedBox(
                width: size.width - 28,
                height: size.width - 28,
                child: ClipRRect(
                  borderRadius: .circular(8),
                  child: MobileScanner(
                    fit: BoxFit.cover,
                    onDetect: (capture) {
                      final barcode = capture.barcodes.first;
                      final String? code = barcode.rawValue;

                      print(code);
                    },
                  ),
                ),
              ),
            ),
          );
        },
        padding: const .symmetric(horizontal: 16, vertical: 8),
        color: AppColor.primaryColor,
        splashColor: Colors.white,
        borderRadius: .circular(30),
        border: .all(color: ColorConverter.lighten(AppColor.primaryColor, 40)),
        child: const Text(
          'Scan QR',
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: .bold),
        ),
      ),
    );
  }
}
