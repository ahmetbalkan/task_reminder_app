import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:task_reminder_app/tools/Color.dart';

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
        color: ColorClass.BackgroundColor,
        child: Center(child: Image.asset("assets/logo.png")));
  }

  gotoPage() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IntroSliderPage(),
          ));
    });
  }
}
