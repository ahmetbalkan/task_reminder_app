import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_reminder_app/tools/extention.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List a = [];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        body: a.isEmpty
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/emptypagevector.png",
                  ),
                  Text(
                    "homepage-empty-list-title".tr(),
                    style: context.fontStyleLato(Colors.white, 20),
                  ),
                  Text(
                    "homepage-empty-list-desc".tr(),
                    style: context.fontStyleLato(Colors.white, 16),
                  )
                ],
              ))
            : Center());
  }
}
