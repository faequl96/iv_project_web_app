import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iv_project_web_app/pages/themes_catalog/themes_catalog_page.dart';

class Utils {
  const Utils._();

  static Future<Uint8List?> capture(
    BuildContext context,
    GlobalKey<State<StatefulWidget>> imageByteKey, {
    required String themeId,
    required String page,
    bool wrapperPrefix = false,
  }) async {
    final boundary = imageByteKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final image = await boundary.toImage(pixelRatio: .8);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) return null;

    final uint8List = await compute(ThemesCatalogPage.encodePng, {
      'width': image.width,
      'height': image.height,
      'bytes': byteData.buffer.asUint8List(),
    });
    if (context.mounted) await precacheImage(MemoryImage(uint8List), context);
    final wrapper = wrapperPrefix ? '_wrapper' : '';
    ThemesCatalogPage.themeImageCaches[themeId]?['$page$wrapper'] = uint8List;

    return uint8List;
  }
}
