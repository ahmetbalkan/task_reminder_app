import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_reminder_app/tools/Color.dart';
import 'package:task_reminder_app/view/intro_slider_page.dart';
import 'package:task_reminder_app/view/splash_screen.dart';

import 'view/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Task Reminder',
            theme: ThemeData(
              primarySwatch: ColorClass.primaryMaterialColor,
            ),
            home: const SplashScreen(),
          );
        });
  }
}
