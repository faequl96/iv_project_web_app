import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/pages/themes_catalog/invitation_theme_item.dart';

class ThemesCatalogPage extends StatefulWidget {
  const ThemesCatalogPage({super.key});

  static final Map<String, Map<String, Uint8List?>> themeImageCaches = {};
  static final Map<String, Uint8List?> themeImagePreviewCaches = {};

  @override
  State<ThemesCatalogPage> createState() => _ThemesCatalogPageState();
}

class _ThemesCatalogPageState extends State<ThemesCatalogPage> {
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

  @override
  void initState() {
    super.initState();

    if (ThemesCatalogPage.themeImageCaches.isEmpty) {
      for (final item in invitationThemes) {
        ThemesCatalogPage.themeImageCaches['theme_${item.id}'] = {};
      }
    }
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
