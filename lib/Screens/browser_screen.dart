import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_downloader/custom_colors.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  @override
  _BrowserScreenState createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  final _webViewLink = 'https://www.youtube.com/';
  bool _showDownloadButton = false;
  WebViewController? _controller;

  void checkIsVideo() async {
    if (await _controller!.currentUrl() == 'https://m.youtube.com/') {
      setState(() {
        _showDownloadButton = false;
      });
    } else {
      setState(() {
        _showDownloadButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkIsVideo();
    return Scaffold(
      body: WebView(
        initialUrl: _webViewLink,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
      ),
      floatingActionButton: _showDownloadButton == false
          ? Container()
          : FloatingActionButton(
              onPressed: () async {
                print(await _controller!.currentUrl());
              },
              backgroundColor: CustomColors.replyOrange(),
              child: const Icon(Icons.download),
            ),
    );
  }
}
