import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_model/iv_project_model.dart';

class InvitationExampleViewerExtra extends Extra {
  const InvitationExampleViewerExtra({
    required this.invitationThemeId,
    required this.invitationThemeName,
    required this.invitationData,
    required this.brandProfile,
    required this.initialPage,
    required this.useWrapper,
    required this.viewAsSinglePage,
  });

  final int invitationThemeId;
  final String invitationThemeName;
  final InvitationDataResponse invitationData;
  final BrandProfileResponse brandProfile;
  final int initialPage;
  final bool useWrapper;
  final bool viewAsSinglePage;
}
