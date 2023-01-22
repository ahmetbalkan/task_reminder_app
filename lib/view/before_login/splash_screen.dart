import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_reminder_app/view/before_login/login/login_screen.dart';
import 'package:task_reminder_app/view/main_page.dart';

import '../../bloc/splash_load_bloc/splash_load_bloc.dart';
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
    context.read<SplashLoadBloc>().add(GetSplashLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.backgroundColor,
        child: BlocConsumer<SplashLoadBloc, SplashLoadState>(
          listener: (context, state) {
            if (state.postStatus == PostStatus.showintro) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IntroSliderPage(),
                  ),
                  (route) => false);
            }
            if (state.postStatus == PostStatus.gologin) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (route) => false);
            }
            if (state.postStatus == PostStatus.gohome) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                  (route) => false);
            }
            if (state.postStatus == PostStatus.goinformation) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                  (route) => false);
            }
          },
          builder: (context, state) {
            if (state.postStatus == PostStatus.loading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset("assets/logo.png")),
                  CircularProgressIndicator()
                ],
              );
            } else {
              return Center();
            }
          },
        ));
  }
}
