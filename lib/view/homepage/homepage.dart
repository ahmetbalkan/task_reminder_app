import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_reminder_app/bloc/task_bloc/task_bloc_bloc.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/tools/extention.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TaskIsarRepository taskIsarRepository = TaskIsarRepository();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        body: StreamBuilder<List<TaskModel>>(
            stream: taskIsarRepository.listenUser(),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(
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
                ));
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var currentSnapshot = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.abc),
                              title: Text(
                                currentSnapshot.title!,
                                style: context.fontStyleLato(Colors.white, 18),
                              ),
                              subtitle: Text(
                                currentSnapshot.desc!,
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
                                      isDismissible: true,
                                      useRootNavigator: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                      ),
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: SizedBox(
                                              height:
                                                  ScreenUtil().screenHeight / 4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                              "assets/line.png")
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "delete-comfirm".tr(),
                                                        style: context
                                                            .fontStyleLato(
                                                                Colors.white,
                                                                20),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  minimumSize:
                                                                      const Size
                                                                              .fromHeight(
                                                                          50),
                                                                  backgroundColor:
                                                                      context
                                                                          .primaryColor),
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        TaskBloc>()
                                                                    .add(DeleteTaskEvent(
                                                                        id: snapshot
                                                                            .data![index]
                                                                            .id));
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "delete".tr(),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  minimumSize:
                                                                      const Size
                                                                              .fromHeight(
                                                                          50),
                                                                  backgroundColor:
                                                                      context
                                                                          .primaryColor),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "cancel".tr(),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
