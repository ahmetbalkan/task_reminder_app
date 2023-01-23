import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_reminder_app/bloc/categories_bloc/category_bloc.dart';
import 'package:task_reminder_app/model/category.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/category_isar_repository.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/tools/extention.dart';
import '../../bloc/test_bloc/cubit/dropdown_cubit.dart';
import '../../bloc/test_bloc/test_bloc.dart';
import '../../locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var _taskIsarRepository = locator.get<TaskIsarRepository>();
var _categoryIsarRepository = locator.get<CategoryIsarRepository>();

late List<String> list;
late TextEditingController _searchController;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    list = <String>[
      'Bu Gün',
      'Tamamlandı',
      'Tümünü Göster',
    ];
    _searchController = TextEditingController();
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
                  controller: _searchController,
                  keyboardAppearance: Brightness.dark,
                  autofocus: false,
                  cursorColor: context.primaryColor,
                  cursorHeight: 24,
                  onChanged: (value) {
                    context.read<TestBloc>().add(SearchTaskEvent(
                        dropDownValue:
                            context.read<DropDownNameCubit>().state.name,
                        searchValue: value));
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    focusColor: context.primaryColor,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: context.primaryColor)),
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        _taskIsarRepository
                            .listenAllUserTask("te")
                            .listen((taskModel) {
                          print(taskModel.length);
                        });
                        for (var i = 0; i < 5; i++) {
                          context.read<TestBloc>().add(AddTestEvent(
                              taskModel: TaskModel(
                                  "title" + i.toString(),
                                  "desc" + i.toString(),
                                  i % 2 == 0
                                      ? DateTime.now().add(Duration(days: 1))
                                      : DateTime.now(),
                                  i % 2 == 0
                                      ? DateTime.now().add(Duration(days: 3))
                                      : DateTime.now().add(Duration(days: 2)),
                                  4,
                                  "Spor",
                                  1,
                                  i % 2 == 0 ? true : false)));
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
                    value: context.watch<DropDownNameCubit>().state.name,
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
                      print(value);
                      switch (value) {
                        case "Tümünü Göster":
                          context.read<TestBloc>().add(SearchTaskEvent(
                              dropDownValue: "Tümünü Göster", searchValue: ""));
                          context
                              .read<DropDownNameCubit>()
                              .setName("Tümünü Göster");
                          break;
                        case "Tamamlandı":
                          context.read<TestBloc>().add(SearchTaskEvent(
                              dropDownValue: "Tamamlandı", searchValue: ""));
                          context
                              .read<DropDownNameCubit>()
                              .setName("Tamamlandı");

                          break;
                        case "Bu Gün":
                          context.read<TestBloc>().add(SearchTaskEvent(
                              dropDownValue: "Bu Gün", searchValue: ""));
                          context.read<DropDownNameCubit>().setName("Bu Gün");

                          break;

                        default:
                      }
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
              print(state);
              if (state is TestInitial) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is AllTaskState) {
                if (state.tasklist.isEmpty || state.tasklist == null) {
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "homepage-empty-list-title".tr(),
                        style: context.fontStyleLato(Colors.white, 20),
                      ),
                      Image.asset(
                        "assets/emptypagevector.png",
                      ),
                      Text(
                        "homepage-empty-list-desc".tr(),
                        style: context.fontStyleLato(Colors.white, 16),
                      )
                    ],
                  ));
                } else {
                  return ListviewMethod(state.tasklist);
                }
              }
              if (state is CompleteTaskState) {
                if (state.tasklist.isEmpty || state.tasklist == null) {
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "homepage-empty-list-title".tr(),
                        style: context.fontStyleLato(Colors.white, 20),
                      ),
                      Image.asset(
                        "assets/emptypagevector.png",
                      ),
                      Text(
                        "homepage-empty-list-desc".tr(),
                        style: context.fontStyleLato(Colors.white, 16),
                      )
                    ],
                  ));
                } else {
                  if (state.tasklist.isEmpty || state.tasklist == null) {
                    return Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "homepage-empty-list-title".tr(),
                          style: context.fontStyleLato(Colors.white, 20),
                        ),
                        Image.asset(
                          "assets/emptypagevector.png",
                        ),
                        Text(
                          "homepage-empty-list-desc".tr(),
                          style: context.fontStyleLato(Colors.white, 16),
                        )
                      ],
                    ));
                  } else {
                    return ListviewMethod(state.tasklist);
                  }
                }
              }
              if (state is TodayTaskState) {
                if (state.tasklist.isEmpty || state.tasklist == null) {
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "homepage-empty-list-title".tr(),
                        style: context.fontStyleLato(Colors.white, 20),
                      ),
                      Image.asset(
                        "assets/emptypagevector.png",
                      ),
                      Text(
                        "homepage-empty-list-desc".tr(),
                        style: context.fontStyleLato(Colors.white, 16),
                      )
                    ],
                  ));
                } else {
                  return ListviewMethod(state.tasklist);
                }
              }
              if (state is SearchTaskState) {
                if (state.tasklist.isEmpty || state.tasklist == null) {
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Arattırılan kelimede içerik bulunamadı. Lütfen tekrar deneyiniz.",
                        textAlign: TextAlign.center,
                        style: context.fontStyleLato(Colors.white, 20),
                      ),
                      Image.asset(
                        "assets/emptypagevector.png",
                      ),
                      Text(
                        "homepage-empty-list-desc".tr(),
                        style: context.fontStyleLato(Colors.white, 16),
                      )
                    ],
                  ));
                } else {
                  return ListviewMethod(state.tasklist);
                }
              } else {
                return Center(
                  child: Text("Sayfa Yüklenemedi"),
                );
              }
            },
          ))
          /*  }
                      }),*/
        ],
      ),
    );
  }

  Widget ListviewMethod(List<TaskModel>? list) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      addSemanticIndexes: false,
      scrollDirection: Axis.vertical,
      itemCount: list!.length,
      itemBuilder: (context, index) {
        var currentSnapshot = list[index];

        return TextButton(
          onPressed: () {
            context.read<TestBloc>().add(EditTestEvent(
                taskModel: currentSnapshot,
                dropDownValue: context.read<DropDownNameCubit>().state.name));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    onPressed: (context) {
                      showConfirmBotomSheet(false, currentSnapshot);
                    },
                    backgroundColor: const Color(0xFF5AA469),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Tamamla',
                  ),
                ],
              ),
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  BlocBuilder<TestBloc, TestState>(
                    builder: (context, state) {
                      return SlidableAction(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        backgroundColor: const Color(0xFFD35D6E),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Sil',
                        onPressed: (BuildContext context) {
                          showConfirmBotomSheet(true, currentSnapshot);
                        },
                      );
                    },
                  ),
                  SlidableAction(
                    backgroundColor: const Color(0xFF709FB0),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Düzenle',
                    onPressed: (BuildContext context) {
                      context.read<TestBloc>().add(EditTestEvent(
                          taskModel: currentSnapshot,
                          dropDownValue:
                              context.read<DropDownNameCubit>().state.name));
                    },
                  )
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
                            child: const VerticalDivider(
                              width: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: StreamBuilder<List<CategoryModel>>(
                              stream: _categoryIsarRepository.listenCategory(),
                              builder: (context, snapshot) {
                                if (snapshot.data == null ||
                                    snapshot.data!.isEmpty) {
                                  return Center();
                                } else {
                                  CategoryModel? category =
                                      snapshot.data?.firstWhere(
                                    (element) =>
                                        element.id ==
                                        currentSnapshot.categoryid,
                                  );
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        IconData(category!.icon,
                                            fontFamily: 'MaterialIcons'),
                                        size: 40,
                                        color: Color(category.categoryColor),
                                      ),
                                      Text(
                                        category.categoryName,
                                        style: context.fontStyleLato(
                                            Color(category.categoryColor), 10),
                                        maxLines: 1,
                                      )
                                    ],
                                  );
                                }
                              }),
                        ),
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
          ),
        );
      },
    );
  }

  showConfirmBotomSheet(bool isDelete, TaskModel task) {
    showModalBottomSheet(
        isDismissible: false,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
                height: ScreenUtil().screenHeight / 1.7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(isDelete
                                ? "assets/delete-task.png"
                                : "assets/complete-task.png")
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          isDelete
                              ? "Görevi Silmek istediğinize emin misiniz?"
                              : "Görevi Tamamlamak istediğinize emin misiniz?",
                          textAlign: TextAlign.center,
                          style: context.fontStyleLatoFontWeigt(
                              Colors.white, 20, FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 15,
                              child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: context.primaryColor,
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                  onPressed: () {
                                    if (isDelete) {
                                      context
                                          .read<TestBloc>()
                                          .add(DeleteTaskEvent(task.id));
                                      Navigator.pop(context);
                                    } else {
                                      context.read<TestBloc>().add(
                                          UpdateButtonTaskEvent(
                                              updatedTask: task));
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    isDelete ? "Sil" : "Tamamla",
                                  )),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 15,
                              child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: context.primaryColor,
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Kapat",
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
