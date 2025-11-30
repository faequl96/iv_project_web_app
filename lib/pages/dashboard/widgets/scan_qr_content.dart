import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_data/iv_project_web_data.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ScanQrContent extends StatefulWidget {
  const ScanQrContent({super.key});

  @override
  State<ScanQrContent> createState() => _ScanQrContentState();
}

class _ScanQrContentState extends State<ScanQrContent> with SingleTickerProviderStateMixin {
  late final MobileScannerController _controller;

  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _handled = false;
  bool _isContainsError = false;

  late final LocaleCubit _localeCubit;
  late final InvitedGuestCubit _invitedGuestCubit;

  void _onDetect(BarcodeCapture value) async {
    if (_handled) return;
    setState(() => _isContainsError = false);
    final invitedGuestId = value.barcodes.first.rawValue;
    if (invitedGuestId != null) {
      _handled = true;

      final success = await _invitedGuestCubit.updateById('t$invitedGuestId', const UpdateInvitedGuestRequest(attendance: true));
      if (!success) {
        setState(() => _isContainsError = true);
        return;
      }

      final invitedGuest = _invitedGuestCubit.state.invitedGuest;
      if (invitedGuest == null) return;
      final souvenir = invitedGuest.souvenir;
      if (souvenir == null) return;

      NavigationService.pop();

      if (!mounted) return;
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
        contentBuilder: (_) => Padding(
          padding: const .all(16),
          child: Column(
            mainAxisSize: .min,
            children: [
              Text('Detail Tamu Undangan', style: AppFonts.inter(fontWeight: .w600, fontSize: 16)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Nama :', style: AppFonts.inter(fontSize: 15)),
                  const Spacer(),
                  Text(invitedGuest.nickname, style: AppFonts.inter(fontSize: 15)),
                ],
              ),
              Row(
                children: [
                  Text('Instansi/Dari :', style: AppFonts.inter(fontSize: 15)),
                  const Spacer(),
                  Text(invitedGuest.nameInstance.split('_').last.replaceAll('-', ' '), style: AppFonts.inter(fontSize: 15)),
                ],
              ),
              Row(
                children: [
                  Text('Souvenir :', style: AppFonts.inter(fontSize: 15)),
                  const Spacer(),
                  Text('Tipe - $souvenir', style: AppFonts.inter(fontSize: 15)),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _localeCubit = context.read<LocaleCubit>();
    _invitedGuestCubit = context.read<InvitedGuestCubit>();

    _controller = MobileScannerController(
      facing: CameraFacing.back,
      detectionSpeed: DetectionSpeed.normal,
      formats: [BarcodeFormat.qrCode],
    );

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const double scanSize = 260;

    return ClipRRect(
      borderRadius: .circular(10),
      child: SizedBox(
        width: size.width - 28,
        height: size.width * 1.5,
        child: Stack(
          children: [
            if (_isContainsError) ...[
              SizedBox(
                width: size.width - 28,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      _localeCubit.state.languageCode == 'id' ? 'Oops. Gagal mengscan QR.' : 'Oops. Failed to scan QR',
                      style: AppFonts.nunito(fontSize: 16, fontWeight: .bold, color: Colors.orange),
                    ),
                    const SizedBox(height: 10),
                    GeneralEffectsButton(
                      onTap: () async {
                        _handled = false;
                        _isContainsError = false;
                        setState(() {});
                      },
                      height: 44,
                      width: 132,
                      borderRadius: .circular(30),
                      color: AppColor.primaryColor,
                      splashColor: Colors.white,
                      useInitialElevation: true,
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          const Icon(Icons.replay_rounded, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            _localeCubit.state.languageCode == 'id' ? 'Coba Lagi' : 'Try Again',
                            style: AppFonts.nunito(fontSize: 15, fontWeight: .bold, color: Colors.white),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              MobileScanner(controller: _controller, onDetect: _onDetect),
              Positioned.fill(
                child: IgnorePointer(child: ColoredBox(color: Colors.black.withValues(alpha: .55))),
              ),
              Center(
                child: ClipPath(
                  clipper: _ScannerHole(scanSize),
                  child: ColoredBox(color: Colors.black.withValues(alpha: .55)),
                ),
              ),
              Center(
                child: SizedBox(
                  width: scanSize,
                  height: scanSize,
                  child: CustomPaint(painter: _ScannerBorderPainter()),
                ),
              ),
              Center(
                child: SizedBox(
                  width: scanSize,
                  height: scanSize,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (_, _) {
                      return Align(
                        alignment: Alignment(0, _animation.value * 2 - 1),
                        child: Container(
                          width: scanSize,
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.red.withValues(alpha: 0), Colors.red, Colors.red.withValues(alpha: 0)],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ScannerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double stroke = 4;
    const double radius = 24;
    final Paint paint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke;

    const double corner = 32;

    Path path = Path();

    path.moveTo(0, corner);
    path.lineTo(0, radius);
    path.moveTo(0, 0 + radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.moveTo(corner, 0);
    path.lineTo(radius, 0);

    path.moveTo(size.width - corner, 0);
    path.lineTo(size.width - radius, 0);
    path.moveTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.moveTo(size.width, corner);
    path.lineTo(size.width, radius);

    path.moveTo(0, size.height - corner);
    path.lineTo(0, size.height - radius);
    path.moveTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.moveTo(corner, size.height);
    path.lineTo(radius, size.height);

    path.moveTo(size.width - corner, size.height);
    path.lineTo(size.width - radius, size.height);
    path.moveTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - radius);
    path.moveTo(size.width, size.height - corner);
    path.lineTo(size.width, size.height - radius);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _ScannerHole extends CustomClipper<Path> {
  _ScannerHole(this.size);

  final double size;

  @override
  Path getClip(Size screenSize) {
    final Path path = Path()..addRect(Rect.fromLTWH(0, 0, screenSize.width, screenSize.height));

    final double left = (screenSize.width - size) / 2;
    final double top = (screenSize.height - size) / 2;

    final Rect hole = Rect.fromLTWH(left, top, size, size);
    path.addRRect(RRect.fromRectAndRadius(hole, const Radius.circular(20)));

    return Path.combine(PathOperation.difference, path, Path()..addRect(hole));
  }

  @override
  bool shouldReclip(_) => false;
}
