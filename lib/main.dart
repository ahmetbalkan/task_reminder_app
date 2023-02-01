import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_reminder_app/bloc/app_start_blocs/forgot_pass_auth/forgotpass_auth_bloc.dart';
import 'package:task_reminder_app/bloc/app_start_blocs/login_auth/login_auth_bloc.dart';
import 'package:task_reminder_app/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:task_reminder_app/bloc/categories_bloc/category_bloc.dart';
import 'package:task_reminder_app/bloc/group_bloc/group_bloc.dart';
import 'package:task_reminder_app/bloc/splash_load_bloc/splash_load_bloc.dart';
import 'package:task_reminder_app/bloc/test_bloc/test_bloc.dart';
import 'package:task_reminder_app/view/before_login/splash_screen.dart';
import 'bloc/app_start_blocs/intropage_bloc/intropage_bloc.dart';
import 'bloc/app_start_blocs/register_auth/register_auth_bloc.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'bloc/test_bloc/cubit/dropdown_cubit.dart';
import 'locator.dart';
import 'repository/task_isar_repository.dart';

void main() async {
  AwesomeNotifications().initialize('resource://mipmap/ic_launcher', [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        playSound: true,
        soundSource: 'resource://raw/task_complete',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ]);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  locatorMethod();

  var _isarTaskService = locator.get<TaskIsarRepository>();

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(
            EasyLocalization(
              path: 'assets/translations',
              fallbackLocale: const Locale('tr', 'TR'),
              supportedLocales: const [
                Locale('tr', 'TR'),
                Locale('en', 'US'),
              ],
              child: DevicePreview(
                enabled: false,
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
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => TaskIsarRepository(),
              )
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => IntroPageBloc(),
                ),
                BlocProvider(
                  create: (context) => LoginAuthBloc(),
                ),
                BlocProvider(
                  create: (context) => RegisterAuthBloc(),
                ),
                BlocProvider(
                  create: (context) => ForgotPassAuthBloc(),
                ),
                BlocProvider(
                  create: (context) => SplashLoadBloc(),
                ),
                BlocProvider(
                    create: (context) => GroupBloc()..add(PremiumCheckEvent())),
                BlocProvider(
                  create: (context) => CategoryBloc()..add(GetCategoryEvent()),
                ),
                BlocProvider(create: (context) => DropDownNameCubit()),
                BlocProvider(
                  create: (context) => TestBloc("Bu Gün")
                    ..add(SearchTaskEvent(
                        dropDownValue: "Bu Gün", searchValue: "")),
                ),
                BlocProvider(
                  create: (context) => CalendarBloc(),
                ),
              ],
              child: MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                debugShowCheckedModeBanner: false,
                locale: context.locale,
                builder: DevicePreview.appBuilder,
                title: 'Task Reminder',
                theme: ThemeData.dark(),
                home: SplashScreen(),
              ),
            ),
          );
        });
  }
}
