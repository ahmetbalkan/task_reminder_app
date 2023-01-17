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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IntroSliderPage(),
                  ));
            }
            if (state.postStatus == PostStatus.gologin) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            }
            if (state.postStatus == PostStatus.gohome) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ));
            }
            if (state.postStatus == PostStatus.goinformation) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ));
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

/*enum PostStatus {
  initial,
  loading,
  showintro,
  gologin,
  gohome,
  goinformation,
}*/