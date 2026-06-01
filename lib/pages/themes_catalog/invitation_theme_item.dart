import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/pages/themes_catalog/invitation_theme_summary_content.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class InvitationThemeItem extends StatelessWidget {
  const InvitationThemeItem({
    super.key,
    required this.invitationTheme,
    required this.loadingImageDelay,
  });

  final InvitationThemeResponse invitationTheme;
  final Duration loadingImageDelay;

  @override
  Widget build(BuildContext context) {
    final githubRepoOwner = 'faequl96';
    final githubRepoName = 'iv-project-theme-preview-image-assets';
    final path = 'uploads/themes/theme_${invitationTheme.id}';
    final fileName = 'preview.webp';
    final uploadTo = '$path/$fileName';
    final imageUrl =
        'https://raw.githubusercontent.com/$githubRepoOwner/$githubRepoName/main/$uploadTo';

    return Padding(
      padding: const .symmetric(horizontal: 6),
      child: QuickButton(
        onTap: () {
          FloatingOverlay.showBottomSheet(
            GlobalContextService.value,
            decoration: BottomSheetDecoration(
              borderRadius: const .only(topLeft: .circular(24), topRight: .circular(24)),
              color: ColorUtil.lighten(AppColor.primaryColor, 94),
            ),
            header: BottomSheetHeader(title: .handleBar(color: Colors.grey.shade700)),
            contentBuilder: (_) => InvitationThemeSummaryContent(invitationTheme: invitationTheme),
          );
        },
        style: QuickButtonStyle(
          width: 150,
          borderRadius: .circular(10),
          padding: const .symmetric(horizontal: 8),
          border: .all(width: .5, color: Colors.black12),
          color: Colors.white,
          hoveredColor: Colors.grey.shade100,
          splashColor: Colors.grey.shade50,
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: .circular(4),
              child: SizedBox(
                height: 150,
                child: ColoredBox(
                  color: Colors.grey.shade100,
                  child: Image.network(
                    imageUrl,
                    frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;
                      if (frame != null) return child;
                      return Center(
                        child: RepaintBoundary(
                          child: SharedPersonalize.loadingWidget(
                            size: 24,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              invitationTheme.name,
              style: const TextStyle(fontSize: 13, fontWeight: .w600, height: 1.4),
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
