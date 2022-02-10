import 'dart:developer';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';

class Download {
  Future<void> downloadAudio(String videoLink) async {
    var videoID = videoLink.substring(videoLink.length - 11);
    var yt = YoutubeExplode();
    var video = await yt.videos.get(videoID);

    var manifest = await yt.videos.streamsClient.getManifest(videoID);
    var streams = manifest.audioOnly.withHighestBitrate();
    var audioTag = streams.tag;

    var title = video.title;

    await FlutterYoutubeDownloader.downloadVideo(videoLink, title, audioTag);
  }

  /* --------------------Testing-----------------------*/
  /*

Future<void> downloadAudioToFile(String link) async {
    // Fethching the audio stream from YouTube
    var videoID = link.substring(link.length - 11);
    var yt = YoutubeExplode();
    var video = await yt.videos.get(videoID);

    inspect(video.title);
    inspect(video.author);

    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(videoID);
    var streams = manifest.audioOnly;

    // Get the audio track with the highest bitrate.
    var audio = streams.first;
    var audioStream = yt.videos.streamsClient.get(audio);

    var fileName = '${video.title}.${audio.container.name.toString()}';

    var file = await _videoFile(fileName);

    var output = file.openWrite(mode: FileMode.writeOnlyAppend);

    await for (final data in audioStream) {
      inspect('Adding stream');
      output.add(data);
    }

    await output.close();

    // Close the YoutubeExplode's http client.
    yt.close();
    inspect('Done');
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/test.txt');
  }

  Future<File> _videoFile(String videoName) async {
    final path = await _localPath;
    return File('$path/$videoName');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<String> readFromTestFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'fail';
    }
  }

  Future<File> writeToTestFile(String text) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(text);
  }
  */
}
