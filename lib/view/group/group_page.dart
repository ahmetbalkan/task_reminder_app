import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_reminder_app/tools/extention.dart';

import '../../bloc/group_bloc/group_bloc.dart';
import '../../bloc/test_bloc/cubit/dropdown_cubit.dart';
import '../../bloc/test_bloc/test_bloc.dart';
import '../../locator.dart';
import '../../model/category.dart';
import '../../model/task.dart';
import '../../repository/category_isar_repository.dart';
import '../../repository/task_isar_repository.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

var _taskIsarRepository = locator.get<TaskIsarRepository>();
var _categoryIsarRepository = locator.get<CategoryIsarRepository>();

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoading) {
            return const CircularProgressIndicator();
          }
          if (state is PremiumCheckState) {
            if (state.isPremium == false) {
              return const Text("Premium Değilsiniz");
            } else {
              return RefreshIndicator(
                displacement: 20,
                backgroundColor: context.backgroundSoftColor,
                color: context.primaryColor,
                strokeWidth: 3,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1500));
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.mediumWidth,
                          vertical: context.lowWidth),
                      child: Container(
                          height: 120.h,
                          width: ScreenUtil().screenWidth,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: context.backgroundsoft,
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Grup ID'niz",
                                      style: context.fontStyleLato(
                                          context.primaryColor, 14)),
                                  Text(
                                    state.groupID,
                                    style:
                                        context.fontStyleLato(Colors.white, 22),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: VerticalDivider(),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: context.primaryColor),
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: state.groupID));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Kopyalandı."),
                                    duration: Duration(milliseconds: 500),
                                  ));
                                },
                                child: const Icon(
                                  FontAwesomeIcons.copy,
                                  size: 30,
                                ),
                              )
                            ],
                          ))),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.mediumWidth,
                          vertical: context.mediumHeight),
                      child: Container(
                          height: 120.h,
                          width: ScreenUtil().screenWidth,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: context.backgroundsoft,
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: context.primaryColor),
                            onPressed: () {},
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text("Gruptaki \nKişiler",
                                      textAlign: TextAlign.end,
                                      style: context.fontStyleLato(
                                          context.primaryColor, 14)),
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: VerticalDivider(),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount:
                                                  state.userList.length > 3
                                                      ? 3
                                                      : state.userList.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return CachedNetworkImage(
                                                    imageUrl: state
                                                        .userList[index]
                                                        .ProfileURL,
                                                    fit: BoxFit.fitHeight,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 4.0),
                                                          child: Container(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: context
                                                                      .primaryColor,
                                                                  width: 2),
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .contain),
                                                            ),
                                                          ),
                                                        ));
                                              },
                                            )),
                                        Visibility(
                                          visible: state.userList.length >= 3
                                              ? true
                                              : false,
                                          child: Expanded(
                                              flex: 1,
                                              child: Icon(
                                                Icons.more_horiz,
                                                color: context.primaryColor,
                                                size: 40,
                                              )),
                                        ),
                                      ]),
                                )
                              ],
                            )),
                          )),
                    ),
                    Text("Grup Görevleri",
                        textAlign: TextAlign.end,
                        style: context.fontStyleLato(context.primaryColor, 18)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(),
                    ),
                    ListviewMethod(state.taskList),
                  ]),
                ),
              );
            }
          } else {
            return const Center(
              child: Text("Yüklemenedi."),
            );
          }
        },
      ),
    );
  }

  Widget ListviewMethod(List<TaskModel>? list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      addSemanticIndexes: false,
      scrollDirection: Axis.vertical,
      itemCount: list!.length,
      itemBuilder: (context, index) {
        var currentSnapshot = list[index];

        return GestureDetector(
          onTap: () {
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
                      //showConfirmBotomSheet(false, currentSnapshot);
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
                          //  showConfirmBotomSheet(true, currentSnapshot);
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
                                  return const Center();
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
}
