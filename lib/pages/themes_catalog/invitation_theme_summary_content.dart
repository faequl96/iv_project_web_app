import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/core/helpers/extra_helper.dart';
import 'package:iv_project_web_app/dummys/dummys.dart';
import 'package:iv_project_web_app/models/extras.dart';
import 'package:iv_project_web_app/pages/themes_catalog/themes_catalog_page.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class InvitationThemeSummaryContent extends StatelessWidget {
  const InvitationThemeSummaryContent({super.key, required this.invitationTheme});

  final InvitationThemeResponse invitationTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: .min,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 14),
                    const Icon(Icons.style, size: 32, color: AppColor.primaryColor),
                    const SizedBox(width: 8),
                    Text(invitationTheme.name, style: const TextStyle(fontWeight: .w600, fontSize: 15)),
                    const Spacer(),
                    const SizedBox(width: 14),
                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: .center,
                  children: [
                    _SinglePageExampleViewers(invitationTheme: invitationTheme),
                    SizedBox(
                      height: 272,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 22,
                            height: .maxFinite,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorConverter.lighten(AppColor.primaryColor, 96).withValues(alpha: 10),
                                    ColorConverter.lighten(AppColor.primaryColor, 96).withValues(alpha: 0),
                                  ],
                                  stops: const [0, .7],
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 22,
                            height: .maxFinite,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorConverter.lighten(AppColor.primaryColor, 96).withValues(alpha: 0),
                                    ColorConverter.lighten(AppColor.primaryColor, 96).withValues(alpha: 10),
                                  ],
                                  stops: const [.3, 1],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: GeneralEffectsButton(
                onTap: () {
                  NavigationService.go(
                    '/invitation-example-viewer',
                    extra: ExtraHelper.sendInvitationExampleViewerExtra(
                      InvitationExampleViewerExtra(
                        invitationThemeId: invitationTheme.id,
                        invitationThemeName: invitationTheme.name,
                        invitationData: Dummys.invitationData,
                        brandProfile: const BrandProfileResponse(
                          name: 'In-Vite Ltd.',
                          email: 'faequl96@gmail.com',
                          phone: '085640933136',
                          instagram: '@faequl96',
                        ),
                        initialPage: 0,
                        useWrapper: true,
                        viewAsSinglePage: false,
                      ),
                    ),
                  );
                },
                height: 52,
                color: AppColor.primaryColor,
                splashColor: Colors.grey.shade300,
                borderRadius: .circular(40),
                useInitialElevation: true,
                child: const Center(
                  child: Text(
                    'Lihat Contoh',
                    style: TextStyle(fontSize: 15, fontWeight: .w600, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {
  const _ImageViewer({required this.invitationTheme, required this.initialPage, this.useWrapper = false});

  final InvitationThemeResponse invitationTheme;
  final bool useWrapper;
  final int initialPage;

  void _gotoExample() {
    NavigationService.push(
      '/invitation-example-viewer',
      extra: ExtraHelper.sendInvitationExampleViewerExtra(
        InvitationExampleViewerExtra(
          invitationThemeId: invitationTheme.id,
          invitationThemeName: invitationTheme.name,
          invitationData: Dummys.invitationData,
          brandProfile: const BrandProfileResponse(
            name: 'In-Vite Ltd.',
            email: 'faequl96@gmail.com',
            phone: '085640933136',
            instagram: '@faequl96',
          ),
          initialPage: initialPage,
          useWrapper: useWrapper,
          viewAsSinglePage: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final githubRepoOwner = 'faequl96';
    final githubRepoName = 'iv-project-theme-preview-image-assets';
    final path = 'uploads/themes/theme_${invitationTheme.id}/pages';
    final fileName = '$initialPage${useWrapper ? '_wrapper' : ''}.webp';
    final uploadTo = '$path/$fileName';
    final imageUrl = 'https://raw.githubusercontent.com/$githubRepoOwner/$githubRepoName/main/$uploadTo';

    return GeneralEffectsButton(
      onTap: _gotoExample,
      child: SizedBox(
        height: 260,
        child: Stack(
          alignment: .center,
          children: [
            FittedBox(
              child: SizedBox(
                height: ThemesCatalogPage.themeCatalogSummaryImagePreviewSize.height,
                width: ThemesCatalogPage.themeCatalogSummaryImagePreviewSize.width,
                child: ColoredBox(color: Colors.grey.shade100),
              ),
            ),
            Image.network(
              imageUrl,
              frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                if (frame != null) return child;
                return Center(
                  child: RepaintBoundary(child: SharedPersonalize.loadingWidget(size: 24, color: AppColor.primaryColor)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SinglePageExampleViewers extends StatelessWidget {
  const _SinglePageExampleViewers({required this.invitationTheme});

  final InvitationThemeResponse invitationTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Padding(
          padding: const .symmetric(horizontal: 16),
          child: Row(
            children: [
              _ImageViewer(useWrapper: true, initialPage: 0, invitationTheme: invitationTheme),
              const SizedBox(width: 8),
              _ImageViewer(initialPage: 0, invitationTheme: invitationTheme),
              const SizedBox(width: 8),
              _ImageViewer(initialPage: 1, invitationTheme: invitationTheme),
              const SizedBox(width: 8),
              _ImageViewer(initialPage: 2, invitationTheme: invitationTheme),
              const SizedBox(width: 8),
              _ImageViewer(initialPage: 3, invitationTheme: invitationTheme),
              const SizedBox(width: 8),
              _ImageViewer(initialPage: 4, invitationTheme: invitationTheme),
              const SizedBox(width: 8),
              _ImageViewer(initialPage: 5, invitationTheme: invitationTheme),
              const SizedBox(width: 8),
              _ImageViewer(initialPage: 6, invitationTheme: invitationTheme),
              const SizedBox(width: 8),
              _ImageViewer(initialPage: 7, invitationTheme: invitationTheme),
              const SizedBox(width: 8),
              _ImageViewer(initialPage: 8, invitationTheme: invitationTheme),
            ],
          ),
        ),
      ),
    );
  }
}
