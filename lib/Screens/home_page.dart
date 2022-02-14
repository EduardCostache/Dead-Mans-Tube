import 'package:flutter/material.dart';
import 'package:youtube_downloader/Screens/browser_screen.dart';
import 'package:youtube_downloader/Screens/paste_link_screen.dart';
import 'package:youtube_downloader/style.dart';

import 'loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Index 0 = Paste Link
  //Index 1 = Browse
  int _currentIndex = 0;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: CustomTheme.primaryColor(),
              title: const Text('Youtube downloader'),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: CustomTheme.primaryColor(),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _currentIndex,
        items: bottomNavItems,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            loading = true;
          });
        },
      ),
      body: loading ? const Loader() : screens[_currentIndex],
    );
  }

  List<Widget> screens = [
    const PasteLinkScreen(),
    const BrowserScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.paste), label: 'Paste link'),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Browse')
  ];
}
