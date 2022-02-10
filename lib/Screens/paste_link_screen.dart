import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_downloader/custom_colors.dart';
import 'package:youtube_downloader/downloader.dart';

class PasteLinkScreen extends StatefulWidget {
  const PasteLinkScreen({Key? key}) : super(key: key);

  @override
  _PasteLinkScreenState createState() => _PasteLinkScreenState();
}

class _PasteLinkScreenState extends State<PasteLinkScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: 'Youtube Link'),
            ),
            GestureDetector(
              onTap: () async {
                var link = _textEditingController.text;

                if (link.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a link!')));
                } else if (link.contains('&list')) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Video link contains playlist, please enter the video link exclusively!')));
                } else if (link.contains('https://youtu.be/') ||
                    (link.contains('https://www.youtube.com/watch?'))) {
                  final permissionStatus = await Permission.storage.request();

                  if (permissionStatus.isGranted) {
                    Download().downloadAudio(link);
                    _textEditingController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Permission to storage not granted! Cannot download video.')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Please enter a valid youtube video link!')));
                }
              },
              child: Container(
                color: CustomColors.replyOrange(),
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Download MP3',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            /* ----------------------------Testing--------------------------
            GestureDetector(
              onTap: () {
                var text = _textEditingController.text;

                Download().writeToTestFile(text);
              },
              child: Container(
                color: CustomColors.replyOrange(),
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Write to File',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var text = await Download().readFromTestFile();

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(text)));
              },
              child: Container(
                color: CustomColors.replyOrange(),
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Read from File',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
