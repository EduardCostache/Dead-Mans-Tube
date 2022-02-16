import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_downloader/Screens/loading_screen.dart';
import 'package:youtube_downloader/Screens/video_info_screen.dart';
import 'package:youtube_downloader/style.dart';

import '../downloader.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  @override
  _BrowserScreenState createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  final _webViewLink = 'https://www.youtube.com/';
  final _watchingVideo = 'https://www.youtube.com/watch?';
  bool _showDownloadButton = false;

  // 1 = show loader
  // 0 = don't show loader
  int _loading = 1;

  WebViewController? _controller;

  void checkIsVideo() async {
    var url = await _controller!.currentUrl();
    url = url!.replaceAll('//m.', '//www.');

    if (url.contains(_watchingVideo)) {
      setState(() {
        _showDownloadButton = true;
      });
    } else if (url.contains(_webViewLink)) {
      setState(() {
        _showDownloadButton = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("You are only limited to 'www.youtube.com'")));
      _controller!.goBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    checkIsVideo();
    return IndexedStack(
      index: _loading,
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: WebView(
              initialUrl: _webViewLink,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                setState(() {
                  _controller = controller;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  _loading = 0;
                });
              },
              onPageStarted: (url) {
                inspect(url);
              },
            ),
          ),
          floatingActionButton: _showDownloadButton == true
              ? FloatingActionButton(
                  onPressed: () async {
                    var link = await _controller!.currentUrl();
                    link = link!.replaceAll('//m.', '//');

                    if (link.contains('&list')) {
                      link = link.split('&list')[0];
                    }

                    final permissionStatus = await Permission.storage.request();

                    if (permissionStatus.isGranted) {
                      //Download().downloadAudio(link);
                      //_textEditingController.clear();
                      setState(() {
                        _loading = 1;
                      });

                      var video = await Download().getVideo(link);

                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VideoInfoPage(video: video)));
                      // After awaiting for the navigator to pop back from the video page, we call setState and change loading to false so that
                      // the screen won't be stuck on loading
                      setState(() {
                        _loading = 0;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Permission to storage not granted! Cannot download video.')));
                    }
                  },
                  backgroundColor: CustomTheme.primaryColor(),
                  child: const Icon(Icons.download),
                )
              : Container(),
        ),
        const Loader(),
      ],
    );
  }
}
