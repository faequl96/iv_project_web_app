import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/pages/themes_catalog/invitation_theme_item.dart';

class ThemesCatalogPage extends StatelessWidget {
  ThemesCatalogPage({super.key});

  static final Map<String, Map<String, Uint8List?>> themeImageCaches = {};
  static final Map<String, Uint8List?> themeImagePreviewCaches = {};

  final invitationThemes = [
    const InvitationThemeResponse(
      id: 1,
      name: 'Elegant Black And White Glass',
      idrPrice: 0,
      idrDiscountPrice: 0,
      ivcPrice: 0,
      ivcDiscountPrice: 0,
      soldCount: 0,
      userIds: [],
      categories: [],
      discountCategories: [],
      reviews: [],
    ),
    const InvitationThemeResponse(
      id: 2,
      name: 'Elegant Red Velvet Glass',
      idrPrice: 0,
      idrDiscountPrice: 0,
      ivcPrice: 0,
      ivcDiscountPrice: 0,
      soldCount: 0,
      userIds: [],
      categories: [],
      discountCategories: [],
      reviews: [],
    ),
    const InvitationThemeResponse(
      id: 3,
      name: 'Elegant Green Matcha Glass',
      idrPrice: 0,
      idrDiscountPrice: 0,
      ivcPrice: 0,
      ivcDiscountPrice: 0,
      soldCount: 0,
      userIds: [],
      categories: [],
      discountCategories: [],
      reviews: [],
    ),
    const InvitationThemeResponse(
      id: 4,
      name: 'Elegant Blue Sky Glass',
      idrPrice: 0,
      idrDiscountPrice: 0,
      ivcPrice: 0,
      ivcDiscountPrice: 0,
      soldCount: 0,
      userIds: [],
      categories: [],
      discountCategories: [],
      reviews: [],
    ),
    const InvitationThemeResponse(
      id: 5,
      name: 'Javanese Rosegold',
      idrPrice: 0,
      idrDiscountPrice: 0,
      ivcPrice: 0,
      ivcDiscountPrice: 0,
      soldCount: 0,
      userIds: [],
      categories: [],
      discountCategories: [],
      reviews: [],
    ),
    const InvitationThemeResponse(
      id: 6,
      name: 'Floral 1',
      idrPrice: 0,
      idrDiscountPrice: 0,
      ivcPrice: 0,
      ivcDiscountPrice: 0,
      soldCount: 0,
      userIds: [],
      categories: [],
      discountCategories: [],
      reviews: [],
    ),
  ];

  static Uint8List encodePng(Map<String, dynamic> params) {
    final int width = params['width'];
    final int height = params['height'];
    final Uint8List rawBytes = params['bytes'];

    final image = img.Image.fromBytes(width: width, height: height, bytes: rawBytes.buffer, order: img.ChannelOrder.rgba);

    return Uint8List.fromList(img.encodePng(image));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const SizedBox(height: 10),
        RepaintBoundary(
          child: SizedBox(
            height: 240,
            child: SingleChildScrollView(
              scrollDirection: .horizontal,
              child: Padding(
                padding: const .symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: [
                    for (int index = 0; index < invitationThemes.length; index++)
                      InvitationThemeItem(
                        invitationTheme: invitationThemes[index],
                        loadingImageDelay: const Duration(milliseconds: 100) + Duration(milliseconds: (index + 1) * 200),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
