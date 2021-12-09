import 'dart:developer';

import 'package:flutter/material.dart';
import 'customColors.dart';

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
    inspect(linkTextController.text);
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
            child: CustomTextField(controller: linkTextController),
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
          controller: controller,
          style: const TextStyle(
            fontSize: 18.0,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'YouTube Link',
          ),
        ),
      ),
    );
  }
}
