import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/tools/extention.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        body: context.read<TaskIsarRepository>().listenUser().length == 0
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
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.abc),
                          title: Text(
                            "asd",
                            style: context.fontStyleLato(Colors.white, 18),
                          ),
                          subtitle: Text(
                            "asd",
                            style: context.fontStyleLato(Colors.white, 14),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text("Düzenle"),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text("Sil"),
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: const SizedBox(
                                          height: 400,
                                          child: Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: TextField(),
                                          ),
                                        ));
                                  },
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ));
  }
}
