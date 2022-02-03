import 'package:flutter/material.dart';
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
              onTap: () {
                var link = _textEditingController.text;
                //TODO: ADD VALIDATION FOR INCORRECT LINK
                if (link.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a link!')));
                } else {
                  //Download().downloadAudioToFile(link);
                  Download().downloadUsingDestinyEDPlugin('testing', link);
                  _textEditingController.clear();
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
          ],
        ),
      ),
    );
  }
}
