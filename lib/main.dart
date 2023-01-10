import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_reminder_app/bloc/app_start_blocs/login_auth/login_auth_bloc.dart';
import 'package:task_reminder_app/view/login_screen.dart';
import 'bloc/app_start_blocs/intropage_bloc/intropage_bloc.dart';
import 'bloc/app_start_blocs/loginpage/login_check_bloc.dart';
import 'bloc/app_start_blocs/register_auth/register_auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(
            EasyLocalization(
              path: 'assets/translations',
              fallbackLocale: const Locale('en', 'US'),
              supportedLocales: const [
                Locale('tr', 'TR'),
                Locale('en', 'US'),
              ],
              child: DevicePreview(
                enabled: true,
                builder: (context) => const MyApp(),
              ),
            ),
          ));
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
                create: (context) => IntroPageBloc(),
              ),
              BlocProvider(
                create: (context) => LoginCheckBloc(),
              ),
              BlocProvider(
                create: (context) => LoginAuthBloc(),
              ),
              BlocProvider(
                create: (context) => RegisterAuthBloc(),
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
              theme: ThemeData.dark(),
              home: const LoginPage(),
            ),
          );
        });
  }
}
