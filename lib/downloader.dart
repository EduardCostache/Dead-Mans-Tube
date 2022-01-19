import 'dart:developer';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Download {
  Future<void> downloadMP3(String link) async {
    var yt = YoutubeExplode();
    var video = await yt.videos.get(link.trim());

    inspect(video.title);
    inspect(video.author);

    // Close the YoutubeExplode's http client.
    yt.close();
  }
}
