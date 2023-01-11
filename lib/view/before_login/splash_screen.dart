import 'package:flutter/material.dart';

import '../../tools/extention.dart';
import 'intro_slider_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.backgroundColor,
        child: Center(child: Image.asset("assets/logo.png")));
  }

  gotoPage() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const IntroSliderPage()),
          (Route<dynamic> route) => false);
    });
  }
}
