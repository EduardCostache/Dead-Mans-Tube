import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youtube_downloader/style.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomTheme.backgroundColor(),
      child: Center(
        child: SpinKitDualRing(
          color: CustomTheme.secondaryColor(),
          size: 50.0,
        ),
      ),
    );
  }
}
