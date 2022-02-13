import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_downloader/style.dart';

import '../downloader.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  //TODO: MAKE IT SO THAT USERS CANT BE REDIRECTED TO ANOTHER SITE OTHER THAN YOUTUBE. FOR EXMAPLE WHEN THEY CLICK ADS.

  @override
  _BrowserScreenState createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  final _webViewLink = 'https://www.youtube.com/';
  bool _showDownloadButton = false;
  WebViewController? _controller;

  void checkIsVideo() async {
    var url = await _controller!.currentUrl();

    if (url!.contains('https://m.youtube.com/watch?')) {
      setState(() {
        _showDownloadButton = true;
      });
    } else {
      setState(() {
        _showDownloadButton = false;
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
                link = link!.replaceAll('//m.', '//');

                if (link.contains('&list')) {
                  link = link.split('&list')[0];
                }
                Download().downloadAudio(link);
              },
              backgroundColor: CustomTheme.primaryColor(),
              child: const Icon(Icons.download),
            )
          : Container(),
    );
  }
}
