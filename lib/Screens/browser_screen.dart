import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_downloader/style.dart';

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
    inspect(await _controller!.currentUrl());
    if (await _controller!.currentUrl() == 'https://m.youtube.com/' ||
        await _controller!.currentUrl() == _webViewLink) {
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
        ),
      ),
      floatingActionButton: _showDownloadButton == true
          ? FloatingActionButton(
              onPressed: () async {
                var link = await _controller!.currentUrl();

                //Download().downloadAudio(link!);
              },
              backgroundColor: CustomTheme.primaryColor(),
              child: const Icon(Icons.download),
            )
          : Container(),
    );
  }
}
