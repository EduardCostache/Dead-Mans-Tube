import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';
import 'custom_colors.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:validators/validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainForm(),
    );
  }
}

class MainForm extends StatefulWidget {
  const MainForm({Key? key}) : super(key: key);

  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  final linkTextController = TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20.0),
      onPrimary: CustomColors.replyBlack(),
      primary: CustomColors.replyOrange());

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    linkTextController.dispose();
    super.dispose();
  }

  void buttonPress() {
    String videoLink = linkTextController.text;

    if (videoLink.isNotEmpty) {
      if (isURL(videoLink)) {
        // TODO: Loading animation
        videoInfo(videoLink);
        //print(videoTitle);
      } else {
        showAlertDialog(context, 'Your link is invalid, please try again.');
      }
    } else {
      showAlertDialog(context, 'Please provide a link.');
    }
  }

  Future<void> videoInfo(String link) async {
    final yt = YoutubeExplode();
    var video = await yt.videos.get(link);
    print(video.title);

    yt.close();
  }

  void showAlertDialog(BuildContext context, String message) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('OK'),
    );

    AlertDialog dialog = AlertDialog(
      title: const Text('There was a problem!'),
      content: Text(message),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.replyBlue700(),
      appBar: AppBar(
        title: const Text('Youtube to MP3'),
        backgroundColor: CustomColors.replyBlue600(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  controller: linkTextController,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'YouTube Link',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              child: const Text('Convert to MP3'),
              onPressed: buttonPress,
              style: style,
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
