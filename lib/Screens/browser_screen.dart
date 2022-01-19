import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  @override
  _BrowserScreenState createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyWebView(),
    );
  }
}

class MyWebView extends StatefulWidget {
  const MyWebView({Key? key}) : super(key: key);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  @override
  Widget build(BuildContext context) {
    return const WebView(
      initialUrl: 'https://www.youtube.com/',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
