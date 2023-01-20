import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/tools/extention.dart';
import '../../bloc/test_bloc/test_bloc.dart';
import '../../locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var _taskIsarRepository = locator.get<TaskIsarRepository>();

late List<String> list;
late String dropdownValue;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    list = <String>[
      'Bu Gün',
      'Tamamlandı',
      'Tümünü Göster',
    ];

    dropdownValue = list.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<TestBloc, TestState>(
                builder: (context, state) {
                  return TextFormField(
                    keyboardAppearance: Brightness.dark,
                    autofocus: false,
                    cursorColor: context.primaryColor,
                    cursorHeight: 24,
                    onChanged: (value) async {
                      if (state is GetCompleteTaskState) {
                        context
                            .read<TestBloc>()
                            .add(GetCompleteTaskEvent(seachValue: value));
                      }
                      if (state is GetAllTaskState) {
                        context
                            .read<TestBloc>()
                            .add(GetAllTaskEvent(seachValue: value));
                      }
                      if (state is GetTodayTaskState) {
                        context
                            .read<TestBloc>()
                            .add(GetTodayTaskEvent(seachValue: value));
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      focusColor: context.primaryColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: context.primaryColor)),
                      prefixIcon: GestureDetector(
                        onTap: () async {
                          for (var i = 0; i < 20; i++) {
                            _taskIsarRepository.saveUser(TaskModel(
                              "title" + i.toString(),
                              "desc" + i.toString(),
                              DateTime.now(),
                              DateTime.now(),
                              2,
                              3,
                              i % 2 == 0 ? true : false,
                              i % 2 == 0 ? true : false,
                            ));
                          }
                        },
                        child: Icon(FontAwesomeIcons.magnifyingGlass,
                            color: context.primaryColor),
                      ),
                      hintText: "Arama",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: context.primaryColor)),
                    ),
                  );
                },
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Görevler",
                      style: context.fontStyleLato(context.primaryColor, 21),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.grey),
                      underline: Container(
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                        ),
                        height: 2,
                      ),
                      iconSize: 15,
                      onChanged: (String? value) {
                        switch (value) {
                          case "Bu Gün":
                            context
                                .read<TestBloc>()
                                .add(GetTodayTaskEvent(seachValue: ""));
                            break;
                          case "Tamamlandı":
                            context
                                .read<TestBloc>()
                                .add(GetCompleteTaskEvent(seachValue: ""));

                            break;
                          case "Tümünü Göster":
                            context
                                .read<TestBloc>()
                                .add(GetAllTaskEvent(seachValue: ""));
                            break;
                          default:
                        }
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                )),
            Expanded(child: BlocBuilder<TestBloc, TestState>(
              builder: (context, state) {
                if (state is TestInitial) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is GetAllTaskState) {
                  return StreamBuilder<List<TaskModel>>(
                      stream: _taskIsarRepository
                          .listenAllUserTask(state.searchValue),
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return ListviewMethod(null);
                        } else {
                          return ListviewMethod(snapshot.data);
                        }
                      });
                }
                if (state is GetTodayTaskState) {
                  return StreamBuilder<List<TaskModel>>(
                      stream: _taskIsarRepository
                          .listenTodayTask(state.searchValue),
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return ListviewMethod(null);
                        } else {
                          return ListviewMethod(snapshot.data);
                        }
                      });
                }
                if (state is GetCompleteTaskState) {
                  return StreamBuilder<List<TaskModel>>(
                      stream: _taskIsarRepository
                          .listenCompleteTask(state.searchValue),
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return ListviewMethod(null);
                        } else {
                          return ListviewMethod(snapshot.data);
                        }
                      });
                }

                return Center(child: Text("sadasd"));
              },
            ))
            /*  }
                    }),*/
          ],
        ));
  }

  Widget ListviewMethod(List<TaskModel>? list) {
    if (list == null) {
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
        physics: const BouncingScrollPhysics(),
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          var currentSnapshot = list[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    onPressed: (context) {},
                    backgroundColor: Color(0xFF709FB0),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Düzenle',
                  ),
                ],
              ),
              startActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  // A SlidableAction can have an icon and/or a label.
                  BlocBuilder<TestBloc, TestState>(
                    builder: (context, state) {
                      return SlidableAction(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        backgroundColor: Color(0xFFD35D6E),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Sil',
                        onPressed: (BuildContext context) {
                          if (state is GetCompleteTaskState) {
                            context
                                .read<TestBloc>()
                                .add(DeleteTaskEvent(currentSnapshot.id));
                            context
                                .read<TestBloc>()
                                .add(GetCompleteTaskEvent(seachValue: ""));
                          }
                          if (state is GetAllTaskState) {
                            context
                                .read<TestBloc>()
                                .add(DeleteTaskEvent(currentSnapshot.id));
                            context
                                .read<TestBloc>()
                                .add(GetAllTaskEvent(seachValue: ""));
                          }
                          if (state is GetTodayTaskState) {
                            context
                                .read<TestBloc>()
                                .add(DeleteTaskEvent(currentSnapshot.id));
                            context
                                .read<TestBloc>()
                                .add(GetTodayTaskEvent(seachValue: ""));
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                decoration: BoxDecoration(
                    color: context.backgroundsoft,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index].title!,
                                  style: context.fontStyleLatoFontWeigt(
                                      context.primaryColor,
                                      18,
                                      FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  list[index].desc!,
                                  style:
                                      context.fontStyleLato(Colors.white, 14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]),
                        ),
                        Expanded(
                          child: Container(
                            height: context.highHeight * 1.5,
                            child: VerticalDivider(
                              width: 2,
                              color: context.primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  IconData(list[index].categoryid!,
                                      fontFamily: 'MaterialIcons'),
                                  size: 40,
                                ),
                                Text(
                                  list[index].categoryid!.toString(),
                                  style:
                                      context.fontStyleLato(Colors.white, 10),
                                )
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      child: const Divider(
                        height: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.circlePlay,
                              size: 18,
                              color: context.primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              context.fomatDate(list[index].startDate!),
                              style: context.fontStyleLatoFontWeigt(
                                  Colors.grey, 10, FontWeight.w100),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.circlePlay,
                              size: 18,
                              color: context.primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              context.fomatTime(list[index].startDate!),
                              style: context.fontStyleLatoFontWeigt(
                                  Colors.grey, 10, FontWeight.w100),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.circleStop,
                              size: 18,
                              color: context.primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              context.fomatDate(list[index].EndDate!),
                              style: context.fontStyleLatoFontWeigt(
                                  Colors.grey, 10, FontWeight.w100),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.circleStop,
                              size: 18,
                              color: context.primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              context.fomatTime(list[index].EndDate!),
                              style: context.fontStyleLatoFontWeigt(
                                  Colors.grey, 10, FontWeight.w100),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
