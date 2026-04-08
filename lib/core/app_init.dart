import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';

class AppInit {
  const AppInit._();

  static void prefetchAudio(InvitationResponse invitation) {
    final audioUrl = invitation.invitationData.general.musicAudioUrl;
    if (audioUrl != null) Audio.setupAudioPlayer(audioUrl);
  }

  static void preCacheImages(InvitationResponse invitation) {
    final data = invitation.invitationData;

    final devicePixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
    final config = ImageConfiguration(devicePixelRatio: devicePixelRatio);

    final coverImageUrl = data.general.coverImageUrl;
    final brideImageUrl = data.bride.imageUrl;
    final groomImageUrl = data.groom.imageUrl;
    final gallery = data.gallery;
    final List<ImageProvider> images = [
      if (coverImageUrl != null) NetworkImage(coverImageUrl),
      NetworkImage(brideImageUrl),
      NetworkImage(groomImageUrl),
      if (gallery.imageURL1 != null) NetworkImage(gallery.imageURL1!),
      if (gallery.imageURL2 != null) NetworkImage(gallery.imageURL2!),
      if (gallery.imageURL3 != null) NetworkImage(gallery.imageURL3!),
      if (gallery.imageURL4 != null) NetworkImage(gallery.imageURL4!),
      if (gallery.imageURL5 != null) NetworkImage(gallery.imageURL5!),
      if (gallery.imageURL6 != null) NetworkImage(gallery.imageURL6!),
      if (gallery.imageURL7 != null) NetworkImage(gallery.imageURL7!),
      if (gallery.imageURL8 != null) NetworkImage(gallery.imageURL8!),
      if (gallery.imageURL9 != null) NetworkImage(gallery.imageURL9!),
      if (gallery.imageURL10 != null) NetworkImage(gallery.imageURL10!),
      if (gallery.imageURL11 != null) NetworkImage(gallery.imageURL11!),
      if (gallery.imageURL12 != null) NetworkImage(gallery.imageURL12!),
    ];

    for (var provider in images) {
      provider.resolve(config);
    }
  }

  static void preCacheDummmyImages(InvitationDataResponse invitationData) {
    final devicePixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
    final config = ImageConfiguration(devicePixelRatio: devicePixelRatio);

    final coverImageUrl = invitationData.general.coverImageUrl;
    final brideImageUrl = invitationData.bride.imageUrl;
    final groomImageUrl = invitationData.groom.imageUrl;
    final gallery = invitationData.gallery;
    final List<ImageProvider> images = [
      if (coverImageUrl != null) AssetImage(coverImageUrl, package: 'iv_project_invitation_theme'),
      AssetImage(brideImageUrl, package: 'iv_project_invitation_theme'),
      AssetImage(groomImageUrl, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL1 != null) AssetImage(gallery.imageURL1!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL2 != null) AssetImage(gallery.imageURL2!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL3 != null) AssetImage(gallery.imageURL3!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL4 != null) AssetImage(gallery.imageURL4!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL5 != null) AssetImage(gallery.imageURL5!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL6 != null) AssetImage(gallery.imageURL6!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL7 != null) AssetImage(gallery.imageURL7!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL8 != null) AssetImage(gallery.imageURL8!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL9 != null) AssetImage(gallery.imageURL9!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL10 != null) AssetImage(gallery.imageURL10!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL11 != null) AssetImage(gallery.imageURL11!, package: 'iv_project_invitation_theme'),
      if (gallery.imageURL12 != null) AssetImage(gallery.imageURL12!, package: 'iv_project_invitation_theme'),
    ];

    for (var provider in images) {
      provider.resolve(config);
    }
  }

  static void preCacheAssetImages() {
    final devicePixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
    final config = ImageConfiguration(devicePixelRatio: devicePixelRatio);

    final List<ImageProvider> images = [
      const AssetImage('assets/backgrounds/base_canvas.jpg', package: 'iv_project_invitation_theme'),
      const AssetImage('assets/backgrounds/floral_1.png', package: 'iv_project_invitation_theme'),
      const AssetImage('assets/backgrounds/floral_flower_blue.png', package: 'iv_project_invitation_theme'),
      const AssetImage('assets/backgrounds/floral_flower_pink.png', package: 'iv_project_invitation_theme'),
      const AssetImage('assets/backgrounds/floral_leaf.png', package: 'iv_project_invitation_theme'),
    ];

    for (var provider in images) {
      provider.resolve(config);
    }
  }

  static Future<InvitationResponse?> getInvitation() async {
    final invitationId = Uri.base.queryParameters['id'];
    if (invitationId == null) return null;

    final url = Uri.parse('${ApiUrl.value}/invitation/id/$invitationId');
    try {
      final response = await http.get(url, headers: {'ngrok-skip-browser-warning': 'true'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final invitation = InvitationResponse.fromJson(data['data']);

        return invitation;
      }
    } catch (_) {
      return null;
    }

    return null;
  }
}
