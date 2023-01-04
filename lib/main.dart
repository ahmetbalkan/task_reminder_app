import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_reminder_app/bloc/intropage_bloc/intropage_bloc.dart';

import 'package:task_reminder_app/tools/extention.dart';

import 'view/intro_slider_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      supportedLocales: [
        Locale('tr', 'TR'),
        Locale('en', 'US'),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => MyApp(), // Wrap your app
      ),
    ),
  );
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
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => IntropageBloc(),
                child: Container(),
              )
            ],
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              locale: context.locale,
              builder: DevicePreview.appBuilder,
              title: 'Task Reminder',
              theme: ThemeData(
                primarySwatch: context.primaryMaterialColor,
              ),
              home: const IntroSliderPage(),
            ),
          );
        });
  }
}
