import 'package:iv_project_web_app/models/extras.dart';

class ExtraHelper {
  const ExtraHelper._();

  static InvitationExampleViewerExtra sendInvitationExampleViewerExtra(InvitationExampleViewerExtra extra) => extra;

  static InvitationExampleViewerExtra? receiveInvitationExampleViewerExtra(Object? extra) {
    if (extra is! InvitationExampleViewerExtra) return null;
    return extra;
  }
}
