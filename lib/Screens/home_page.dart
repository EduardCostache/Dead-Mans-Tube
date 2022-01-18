import 'package:flutter/material.dart';
import 'package:youtube_downloader/Screens/browser_screen.dart';
import 'package:youtube_downloader/Screens/paste_link_screen.dart';
import 'package:youtube_downloader/custom_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Index 0 = Paste Link
  //Index 1 = Browse
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.replyOrange(),
        title: const Text('Youtube downloader'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: CustomColors.replyOrange(),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _currentIndex,
        items: bottomNavItems,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      body: screens[_currentIndex],
    );
  }

  List<Widget> screens = [
    PasteLinkScreen(),
    BrowserScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.paste), label: 'Paste link'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Browse')
  ];
}
