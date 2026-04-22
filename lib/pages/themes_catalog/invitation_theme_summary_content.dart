import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_app/core/helpers/extra_helper.dart';
import 'package:iv_project_web_app/core/utils/utils.dart';
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
                    Text(invitationTheme.name, style: const TextStyle(fontWeight: .bold, fontSize: 15)),
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
                    style: TextStyle(fontSize: 15, fontWeight: .bold, color: Colors.white),
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

class _SinglePageExampleViewer extends StatefulWidget {
  const _SinglePageExampleViewer({
    required this.invitationTheme,
    required this.initialPage,
    this.useWrapper = false,
    required this.loadingDelay,
    required this.captureDelay,
  });

  final InvitationThemeResponse invitationTheme;
  final bool useWrapper;
  final int initialPage;
  final Duration loadingDelay;
  final Duration captureDelay;

  @override
  State<_SinglePageExampleViewer> createState() => _SinglePageExampleViewerState();
}

class _SinglePageExampleViewerState extends State<_SinglePageExampleViewer> {
  ValueNotifier<bool>? _isLoading;

  final _imageByteKey = GlobalKey();
  Uint8List? _byteData;

  void _init() async {
    await Future<void>.delayed(widget.loadingDelay);
    _isLoading?.value = false;
    await Future<void>.delayed(widget.captureDelay);

    if (mounted) {
      if (widget.initialPage <= 2) {
        _byteData = await Utils.capture(
          context,
          _imageByteKey,
          themeId: 'theme_${widget.invitationTheme.id}',
          page: 'page_${widget.initialPage}',
          wrapperPrefix: widget.useWrapper,
        );
        setState(() {});
      } else {
        Utils.capture(
          context,
          _imageByteKey,
          themeId: 'theme_${widget.invitationTheme.id}',
          page: 'page_${widget.initialPage}',
          wrapperPrefix: widget.useWrapper,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    final id = widget.invitationTheme.id;
    final page = widget.initialPage;
    final wrapper = widget.useWrapper ? '_wrapper' : '';
    _byteData = ThemesCatalogPage.themeImageCaches['theme_$id']?['page_$page$wrapper'];
    print('initialPage1: ${widget.initialPage}');
    if (_byteData != null) return;

    print('initialPage2: ${widget.initialPage}');
    _isLoading = ValueNotifier(true);
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  @override
  void dispose() {
    _isLoading?.dispose();
    _byteData = null;

    super.dispose();
  }

  void _gotoExample() {
    NavigationService.push(
      '/invitation-example-viewer',
      extra: ExtraHelper.sendInvitationExampleViewerExtra(
        InvitationExampleViewerExtra(
          invitationThemeId: widget.invitationTheme.id,
          invitationThemeName: widget.invitationTheme.name,
          invitationData: Dummys.invitationData,
          brandProfile: const BrandProfileResponse(
            name: 'In-Vite Ltd.',
            email: 'faequl96@gmail.com',
            phone: '085640933136',
            instagram: '@faequl96',
          ),
          initialPage: widget.initialPage,
          useWrapper: widget.useWrapper,
          viewAsSinglePage: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_byteData != null) return GeneralEffectsButton(onTap: _gotoExample, child: Image.memory(_byteData!));

    if (_isLoading == null) return const SizedBox.shrink();
    return Stack(
      alignment: .center,
      children: [
        FittedBox(
          child: SizedBox(
            height: Screen.height,
            width: Screen.width,
            child: ColoredBox(color: Colors.grey.shade200),
          ),
        ),
        SharedPersonalize.loadingWidget(color: AppColor.primaryColor, size: 24),
        Positioned(
          left: -Screen.width,
          child: FittedBox(
            child: RepaintBoundary(
              key: _imageByteKey,
              child: ValueListenableBuilder(
                valueListenable: _isLoading!,
                builder: (_, value, _) {
                  if (value) return const SizedBox.shrink();
                  return ColoredBox(
                    color: Colors.white,
                    child: InvitationThemeAsImageLauncher(
                      invitationThemeId: widget.invitationTheme.id,
                      invitationData: Dummys.invitationData,
                      brandProfile: const BrandProfileResponse(
                        name: 'In-Vite Ltd.',
                        email: 'faequl96@gmail.com',
                        phone: '085640933136',
                        instagram: '@faequl96',
                      ),
                      initialPage: widget.initialPage,
                      useWrapper: widget.useWrapper,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SinglePageExampleViewerAsImage extends StatelessWidget {
  const _SinglePageExampleViewerAsImage({required this.invitationTheme, required this.initialPage, this.useWrapper = false});

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
    final wrapper = useWrapper ? '_wrapper' : '';
    final byteData = ThemesCatalogPage.themeImageCaches['theme_${invitationTheme.id}']?['page_$initialPage$wrapper'];
    if (byteData != null) return GeneralEffectsButton(onTap: _gotoExample, child: Image.memory(byteData));

    return const SizedBox.shrink();
  }
}

class _SinglePageExampleViewers extends StatefulWidget {
  const _SinglePageExampleViewers({required this.invitationTheme});

  final InvitationThemeResponse invitationTheme;

  @override
  State<_SinglePageExampleViewers> createState() => _SinglePageExampleViewersState();
}

class _SinglePageExampleViewersState extends State<_SinglePageExampleViewers> {
  bool _loop = true;

  void _init() async {
    while (_loop) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final imageCachesLength = ThemesCatalogPage.themeImageCaches['theme_${widget.invitationTheme.id}']?.length;
      if (imageCachesLength == 10) {
        _loop = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

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
              if (_loop) ...[
                _SinglePageExampleViewer(
                  useWrapper: true,
                  initialPage: 0,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 250),
                  captureDelay: const Duration(milliseconds: 250),
                ),
                const SizedBox(width: 8),
                _SinglePageExampleViewer(
                  initialPage: 0,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 500),
                  captureDelay: const Duration(milliseconds: 250),
                ),
                const SizedBox(width: 8),
                _SinglePageExampleViewer(
                  initialPage: 1,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 1500),
                  captureDelay: const Duration(milliseconds: 250),
                ),
                const SizedBox(width: 8),
                _SinglePageExampleViewer(
                  initialPage: 2,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 1500),
                  captureDelay: const Duration(milliseconds: 500),
                ),
                const SizedBox(width: 8),
                _SinglePageExampleViewer(
                  initialPage: 3,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 1500),
                  captureDelay: const Duration(milliseconds: 750),
                ),
                const SizedBox(width: 8),
                _SinglePageExampleViewer(
                  initialPage: 4,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 1500),
                  captureDelay: const Duration(milliseconds: 1000),
                ),
                const SizedBox(width: 8),
                _SinglePageExampleViewer(
                  initialPage: 5,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 1500),
                  captureDelay: const Duration(milliseconds: 1250),
                ),
                const SizedBox(width: 8),
                _SinglePageExampleViewer(
                  initialPage: 6,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 1500),
                  captureDelay: const Duration(milliseconds: 1500),
                ),
                const SizedBox(width: 8),
                _SinglePageExampleViewer(
                  initialPage: 7,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 1500),
                  captureDelay: const Duration(milliseconds: 1750),
                ),
                const SizedBox(width: 8),
                _SinglePageExampleViewer(
                  initialPage: 8,
                  invitationTheme: widget.invitationTheme,
                  loadingDelay: const Duration(milliseconds: 1500),
                  captureDelay: const Duration(milliseconds: 2000),
                ),
              ] else ...[
                _SinglePageExampleViewerAsImage(useWrapper: true, initialPage: 0, invitationTheme: widget.invitationTheme),
                const SizedBox(width: 8),
                _SinglePageExampleViewerAsImage(initialPage: 0, invitationTheme: widget.invitationTheme),
                const SizedBox(width: 8),
                _SinglePageExampleViewerAsImage(initialPage: 1, invitationTheme: widget.invitationTheme),
                const SizedBox(width: 8),
                _SinglePageExampleViewerAsImage(initialPage: 2, invitationTheme: widget.invitationTheme),
                const SizedBox(width: 8),
                _SinglePageExampleViewerAsImage(initialPage: 3, invitationTheme: widget.invitationTheme),
                const SizedBox(width: 8),
                _SinglePageExampleViewerAsImage(initialPage: 4, invitationTheme: widget.invitationTheme),
                const SizedBox(width: 8),
                _SinglePageExampleViewerAsImage(initialPage: 5, invitationTheme: widget.invitationTheme),
                const SizedBox(width: 8),
                _SinglePageExampleViewerAsImage(initialPage: 6, invitationTheme: widget.invitationTheme),
                const SizedBox(width: 8),
                _SinglePageExampleViewerAsImage(initialPage: 7, invitationTheme: widget.invitationTheme),
                const SizedBox(width: 8),
                _SinglePageExampleViewerAsImage(initialPage: 8, invitationTheme: widget.invitationTheme),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
