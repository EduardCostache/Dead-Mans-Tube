import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_downloader/Screens/video_info_screen.dart';
import 'package:youtube_downloader/style.dart';
import 'package:youtube_downloader/downloader.dart';

import 'loading.dart';

class PasteLinkScreen extends StatefulWidget {
  const PasteLinkScreen({Key? key}) : super(key: key);

  @override
  _PasteLinkScreenState createState() => _PasteLinkScreenState();
}

class _PasteLinkScreenState extends State<PasteLinkScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loader()
        : Scaffold(
            body: Container(
              color: CustomTheme.backgroundColor(),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _textEditingController,
                    decoration:
                        const InputDecoration(labelText: 'Youtube Link'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          CustomTheme.primaryColor(),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(20),
                        ),
                      ),
                      onPressed: () async {
                        var link = _textEditingController.text;

                        if (link.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter a link!')));
                        } else if (link.contains('&list')) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Video link contains playlist, please enter the video link exclusively!')));
                        } else if (link.contains('https://youtu.be/') ||
                            (link.contains('https://www.youtube.com/watch?'))) {
                          final permissionStatus =
                              await Permission.storage.request();

                          if (permissionStatus.isGranted) {
                            //Download().downloadAudio(link);
                            //_textEditingController.clear();
                            setState(() {
                              loading = true;
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
                              loading = false;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Permission to storage not granted! Cannot download video.')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Please enter a valid youtube video link!')));
                        }
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Download Music'),
                    ),
                  ),
                  /* ----------------------------Testing--------------------------
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
