import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/tools/extention.dart';

import '../../bloc/task_bloc/task_bloc.dart';
import '../../bloc/test_bloc/test_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TaskIsarRepository taskIsarRepository = TaskIsarRepository();
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
              child: TextFormField(
                autofocus: false,
                cursorColor: context.primaryColor,
                cursorHeight: 24,
                onChanged: (value) {
                  context
                      .read<TestBloc>()
                      .add(GetSearchTaskEvent(seachValue: value));
                },
                decoration: InputDecoration(
                  isDense: true,
                  focusColor: context.primaryColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor)),
                  prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass,
                      color: context.primaryColor),
                  hintText: "Arama",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor)),
                ),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    titleMethod(),
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
                            context.read<TestBloc>().add(GetTodayTaskEvent());
                            break;
                          case "Tamamlandı":
                            context
                                .read<TestBloc>()
                                .add(GetCompleteTaskEvent());

                            break;
                          case "Tümünü Göster":
                            context.read<TestBloc>().add(GetAllTaskEvent());
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
                  return CircularProgressIndicator();
                }
                if (state is GetAllTaskState) {
                  return ListviewMethod(state.allTask);
                }
                if (state is GetCompleteTaskState) {
                  return ListviewMethod(state.completeTask);
                }
                if (state is GetSearchTaskState) {
                  return ListviewMethod(state.searchTask);
                }
                return Center();
              },
            ))
            /*  }
                    }),*/
          ],
        ));
  }

  Widget titleMethod() {
    return BlocBuilder<TestBloc, TestState>(
      builder: (context, state) {
        if (state is TestInitial) {
          return CircularProgressIndicator();
        }
        if (state is GetAllTaskState) {
          return Text(
            state.name,
            style: context.fontStyleLato(context.primaryColor, 21),
          );
        }
        if (state is GetCompleteTaskState) {
          return Text(
            state.name,
            style: context.fontStyleLato(context.primaryColor, 21),
          );
        }
        return Center();
      },
    );
  }

  Widget ListviewMethod(List<TaskModel>? list) {
    if (list!.length < 1) {
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
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
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
                                    context.primaryColor, 18, FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                list[index].desc!,
                                style: context.fontStyleLato(Colors.white, 14),
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
                                style: context.fontStyleLato(Colors.white, 10),
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
                            context.fomatDate(list[index].dateTimeFinish!),
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
                            context.fomatTime(list[index].dateTimeFinish!),
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
                            context.fomatDate(list[index].dateTimeFinish!),
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
                            context.fomatTime(list[index].dateTimeFinish!),
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
          );
        },
      );
    }
  }
}
