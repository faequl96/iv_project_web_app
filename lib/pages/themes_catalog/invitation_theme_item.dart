import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/dummys/dummys.dart';
import 'package:iv_project_web_app/pages/themes_catalog/invitation_theme_summary_content.dart';
import 'package:iv_project_web_app/pages/themes_catalog/themes_catalog_page.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class InvitationThemeItem extends StatelessWidget {
  const InvitationThemeItem({super.key, required this.invitationTheme, required this.loadingImageDelay});

  final InvitationThemeResponse invitationTheme;
  final Duration loadingImageDelay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 6),
      child: GeneralEffectsButton(
        onTap: () {
          ShowModal.bottomSheet(
            GlobalContextService.value,
            decoration: BottomSheetDecoration(
              borderRadius: const .only(topLeft: .circular(24), topRight: .circular(24)),
              color: ColorConverter.lighten(AppColor.primaryColor, 94),
            ),
            header: BottomSheetHeader(title: .handleBar(color: Colors.grey.shade700)),
            contentBuilder: (_) => InvitationThemeSummaryContent(invitationTheme: invitationTheme),
          );
        },
        width: 150,
        borderRadius: .circular(10),
        padding: const .symmetric(horizontal: 8),
        border: .all(width: .5, color: Colors.black12),
        color: Colors.white,
        splashColor: Colors.white,
        useInitialElevation: true,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(height: 8),
            // ClipRRect(
            //   borderRadius: .circular(4),
            //   child: ColoredBox(
            //     color: Colors.grey.shade100,
            //     child: _ThemeImage(invitationThemeId: invitationTheme.id, loadingDelay: loadingImageDelay),
            //   ),
            // ),
            const SizedBox(height: 6),
            Text(
              invitationTheme.name,
              style: const TextStyle(fontSize: 13, fontWeight: .bold, height: 1.4),
              maxLines: 1,
              overflow: .ellipsis,
            ),
            // RatingView(starSize: 13, textSize: 13, ratings: invitationTheme.reviews.map((e) => e.star).toList()),
            // const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}

class _ThemeImage extends StatefulWidget {
  const _ThemeImage({required this.invitationThemeId, required this.loadingDelay});

  final int invitationThemeId;
  final Duration loadingDelay;

  @override
  State<_ThemeImage> createState() => _ThemeImageState();
}

class _ThemeImageState extends State<_ThemeImage> {
  final _isLoading = ValueNotifier(true);

  final _imageByteKey = GlobalKey();
  Uint8List? _byteData;

  Future<void> _capture() async {
    try {
      final boundary = _imageByteKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary != null) {
        final image = await boundary.toImage(pixelRatio: 3);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        if (byteData == null) return;

        _byteData = await compute(ThemesCatalogPage.encodePng, {
          'width': image.width,
          'height': image.height,
          'bytes': byteData.buffer.asUint8List(),
        });
        if (mounted) await precacheImage(MemoryImage(_byteData!), context);

        final id = widget.invitationThemeId;
        ThemesCatalogPage.themeImagePreviewCaches['theme_$id'] = _byteData;
        setState(() {});
      }
    } catch (_) {}
  }

  void _init() async {
    await Future<void>.delayed(widget.loadingDelay);
    _isLoading.value = false;
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    _capture();
  }

  @override
  void initState() {
    super.initState();

    final id = widget.invitationThemeId;
    _byteData = ThemesCatalogPage.themeImagePreviewCaches['theme_$id'];
    if (_byteData != null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  @override
  void dispose() {
    _byteData = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_byteData != null) return Image.memory(_byteData!);

    return Stack(
      alignment: .center,
      children: [
        SizedBox(
          height: 150,
          width: .maxFinite,
          child: ColoredBox(color: Colors.grey.shade200),
        ),
        SharedPersonalize.loadingWidget(color: AppColor.primaryColor, size: 24),
        Positioned(
          left: -Screen.width,
          child: ValueListenableBuilder(
            valueListenable: _isLoading,
            builder: (_, value, _) {
              if (value) return const SizedBox.shrink();
              return RepaintBoundary(
                key: _imageByteKey,
                child: SizedBox(
                  height: 150,
                  width: 134,
                  child: Stack(
                    alignment: .center,
                    children: [
                      Positioned(left: 10, child: SizedBox(height: 105, child: _themeImage(page: 0, useWrapper: false))),
                      Positioned(right: 10, child: SizedBox(height: 105, child: _themeImage(page: 7, useWrapper: false))),
                      SizedBox(height: 120, child: _themeImage(page: 0, useWrapper: true)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _themeImage({required int page, required bool useWrapper}) => FittedBox(
    child: ColoredBox(
      color: Colors.white,
      child: InvitationThemeAsImageLauncher(
        invitationThemeId: widget.invitationThemeId,
        invitationData: Dummys.invitationData,
        brandProfile: const BrandProfileResponse(
          name: 'In-Vite Ltd.',
          email: 'faequl96@gmail.com',
          phone: '085640933136',
          instagram: '@faequl96',
        ),
        initialPage: page,
        useWrapper: useWrapper,
      ),
    ),
  );
}
