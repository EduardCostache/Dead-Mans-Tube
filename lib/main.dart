import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Youtube to MP3'),
        backgroundColor: Colors.redAccent[700],
      ),
      body: Center(
        child: Container(
          child: TextField(),
          padding: const EdgeInsets.all(16.0),
        ),
      ),
    ));
  }
}
