import 'package:flutter/material.dart';
import 'package:youtube_downloader/style.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../downloader.dart';

class VideoInfoPage extends StatefulWidget {
  final Video video;

  const VideoInfoPage({Key? key, required this.video}) : super(key: key);

  @override
  _VideoInfoPageState createState() => _VideoInfoPageState();
}

class _VideoInfoPageState extends State<VideoInfoPage> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController =
        TextEditingController(text: widget.video.title.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryColor(),
        title: const Text('Your Video'),
      ),
      body: ListView(
        children: [
          Container(
            child: Image.network(widget.video.thumbnails.standardResUrl),
            padding: const EdgeInsets.all(8),
          ),
          _buildHeader('Title'),
          Container(
            child: TextField(
              autofocus: false,
              controller: _textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.center,
            ),
            padding: const EdgeInsets.all(8),
          ),
          _buildHeader('Author'),
          Container(
            child: TextField(
              style: const TextStyle(color: Colors.grey),
              autofocus: false,
              enabled: false,
              controller: TextEditingController(
                text: widget.video.author.toString(),
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.center,
            ),
            padding: const EdgeInsets.all(8),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  CustomTheme.primaryColor(),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(20),
                ),
              ),
              onPressed: () async {
                var title = _textEditingController.text;

                if (title.endsWith('.') ||
                    title.endsWith('/') ||
                    title.endsWith(' ')) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Video title cannot end with a '.', '/' or a space!")));
                } else if (title.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Video title cannot be empty!')));
                } else {
                  setState(() {});
                  Download().downloadAudio(widget.video.url, title);
                  Navigator.pop(context);
                }
              },
              child: const Text('Confirm'),
            ),
          )
        ],
      ),
    );
  }

  Container _buildHeader(String text) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
