import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Download {
  Future<void> downloadMP3(String link) async {
    final baseStorage = await getExternalStorageDirectory();
    Directory(baseStorage.toString()).createSync();

    // Fethching the audio stream from YouTube
    var videoID = link.substring(link.length - 11);
    var yt = YoutubeExplode();
    var video = await yt.videos.get(videoID);
    var videoTitle = video.title;

    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(videoID);
    var streams = manifest.videoOnly;

    // Get the audio track with the highest bitrate.
    var audio = streams.first;
    var audioStream = yt.videos.streamsClient.get(audio);

    var fileName = '${video.title}.${audio.container.name.toString()}'
        .replaceAll(r'\', '')
        .replaceAll('/', '')
        .replaceAll('*', '')
        .replaceAll('?', '')
        .replaceAll('"', '')
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('|', '')
        .replaceAll(' ', '_');

    var file = File('$baseStorage/$fileName');

    var output = file.openWrite(mode: FileMode.writeOnlyAppend);

    await for (final data in audioStream) {
      output.add(data);
    }

    await output.close();

    inspect(video.title);
    inspect(video.author);

    // Close the YoutubeExplode's http client.
    yt.close();
  }
}
