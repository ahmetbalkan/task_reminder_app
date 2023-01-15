import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_button/group_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:task_reminder_app/bloc/task_bloc/task_bloc_bloc.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/tools/extention.dart';
import 'calendar/calendar_page.dart';
import 'group/group_page.dart';
import 'homepage/homepage.dart';
import 'profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

late PersistentTabController _controller;
late TextEditingController _titleTextEditingController;
late TextEditingController _descTextEditingController;
final _formKey = GlobalKey<FormState>();
DateTime? selectedDate;
TimeOfDay? _pickedTime;
DateTime? _pickedDate;

int? _categoryid;
int? _priority;
bool _switchValue = false;

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _descTextEditingController = TextEditingController();
    _titleTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    _descTextEditingController.dispose();
    _titleTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext buildcontext) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: context.backgroundColor,
          appBar: AppBar(
            title: Text("index".tr()),
            backgroundColor: context.backgroundColor,
            elevation: 1,
            centerTitle: true,
            leadingWidth: 100,
            leading: Row(children: [
              const SizedBox(width: 15),
              Center(child: Image.asset("assets/menu.png")),
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: VerticalDivider(
                  width: 3,
                  color: Colors.white24,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ]),
            actions: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: VerticalDivider(
                  width: 4,
                  color: Colors.white24,
                ),
              ),
              const SizedBox(width: 15),
              Center(
                  child: CircleAvatar(
                backgroundImage: const AssetImage('assets/profile.png'),
                radius: 18.h,
              )),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          body: PersistentTabView(
            context,
            hideNavigationBar: false,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: context.backgroundSoftColor,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(1.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.linear,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style15,
          )),
    );
  }

  List<Widget> _buildScreens() {
    return const [
      HomePage(),
      CalendarPage(),
      GroupPage(),
      GroupPage(),
      ProfilePage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("home".tr()),
        activeColorPrimary: context.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.star),
        title: ("calendar".tr()),
        activeColorPrimary: context.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.plus, color: Colors.white),
        title: ("addtask".tr()),
        onPressed: (p0) {
          _showAddBottomSheetWidget();
        },
        activeColorPrimary: context.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.star),
        title: ("group".tr()),
        activeColorPrimary: context.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("settings".tr()),
        activeColorPrimary: context.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  Future<dynamic> _showAddBottomSheetWidget() {
    return showModalBottomSheet(
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
                height: ScreenUtil().screenHeight / 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Image.asset("assets/line.png")],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "add-task".tr(),
                                style: context.fontStyleLatoFontWeigt(
                                    Colors.white, 20, FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(flex: 3, child: titleTextFieldMethod(context)),
                        Expanded(flex: 4, child: descTextfieldMethod(context)),
                        Expanded(
                            flex: 2,
                            child: errorTextAndNotificationMethod(context)),
                        Expanded(
                          flex: 2,
                          child: dateCategoryPrioritySendButtonMethod(context),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  TextFormField titleTextFieldMethod(BuildContext context) {
    return TextFormField(
      autofocus: false,
      cursorColor: context.primaryColor,
      controller: _titleTextEditingController,
      cursorHeight: 30,
      style: context.fontStyleLato(Colors.white, 18),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'emptyText'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: context.backgroundSoftColor,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.primaryColor)),
          suffixIcon: GestureDetector(
              onTap: () {
                _titleTextEditingController.text = "";
              },
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.deleteLeft,
                    size: 25.0,
                    color: context.primaryColor,
                  ),
                ),
              )),
          focusColor: context.primaryColor,
          isDense: true,
          hintText: "taskaddtitle".tr(),
          border: const UnderlineInputBorder(borderSide: BorderSide())),
    );
  }

  TextFormField descTextfieldMethod(BuildContext context) {
    return TextFormField(
      style: context.fontStyleLato(Colors.white, 16),
      autofocus: false,
      cursorColor: context.primaryColor,
      controller: _descTextEditingController,
      cursorHeight: 25,
      maxLines: 4,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'emptyText'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
          fillColor: context.backgroundSoftColor,
          filled: true,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.primaryColor)),
          suffixIcon: GestureDetector(
              onTap: () {
                _descTextEditingController.text = "";
              },
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.deleteLeft,
                    size: 25.0,
                    color: context.primaryColor,
                  ),
                ),
              )),
          focusColor: context.primaryColor,
          isDense: true,
          hintText: "taskadddesc".tr(),
          border: const UnderlineInputBorder(borderSide: BorderSide())),
    );
  }

  Widget errorTextAndNotificationMethod(BuildContext errorcontext) {
    print("errorTextAndNotificationMethod");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<TaskBloc, TaskBlocState>(
          builder: (context, state) {
            return Text(state.errorText);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: StatefulBuilder(
              builder: (context, setState) {
                return CupertinoSwitch(
                  activeColor: CupertinoColors.activeBlue,
                  onChanged: (bool value) {
                    setState(() => _switchValue = value);
                  },
                  value: _switchValue,
                );
              },
            )),
            Text(
              "Bildirim Oluştur.",
              style: context.fontStyleLato(Colors.white, 16),
            )
          ],
        )
      ],
    );
  }

  Widget dateCategoryPrioritySendButtonMethod(BuildContext context) {
    print("dateCategoryPrioritySendButtonMethod");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () async {
                _pickedDate = await showDatePicker(
                    helpText: "LÜTFEN ALARM TARİHİNİ SEÇİNİZ",
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1));

                _pickedTime = await showTimePicker(
                  helpText: "LÜTFEN ALARM SAATİNİ SEÇİNİZ",
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
              },
              icon: const SizedBox(
                  child: Icon(
                FontAwesomeIcons.clock,
                color: Colors.white54,
              )),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: const EdgeInsets.all(8.0),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Choose Category",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 2,
                              ),
                            ],
                          ),
                          content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.4,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: GridView.builder(
                                      itemCount: 20,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            _categoryid = index;

                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        context.backgroundsoft,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                6))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    const Icon(FontAwesomeIcons
                                                        .solidFlag),
                                                    Text(
                                                        (index + 1).toString()),
                                                  ],
                                                ),
                                              )),
                                        );
                                      },
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: SizedBox(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                const Size.fromHeight(50),
                                            backgroundColor:
                                                context.primaryColor),
                                        onPressed: () {},
                                        child: Text(
                                          "Add Category",
                                          style: context.fontStyleLato(
                                              Colors.white, 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      });
                },
                icon: const Icon(
                  FontAwesomeIcons.tag,
                  color: Colors.white54,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: const EdgeInsets.all(8.0),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Edit Task Priority",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 2,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.4,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            _priority = index;
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        context.backgroundsoft,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                6))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    const Icon(FontAwesomeIcons
                                                        .solidFlag),
                                                    Text(
                                                        (index + 1).toString()),
                                                  ],
                                                ),
                                              )),
                                        );
                                      },
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: SizedBox(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                const Size.fromHeight(50),
                                            backgroundColor:
                                                context.primaryColor),
                                        onPressed: () {},
                                        child: Text(
                                          "Add Category",
                                          style: context.fontStyleLato(
                                              Colors.white, 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      });
                },
                icon: const Icon(
                  FontAwesomeIcons.solidFlag,
                  color: Colors.white54,
                )),
          ],
        ),
        BlocListener<TaskBloc, TaskBlocState>(
          listener: (context, state) {
            print(state.postStatus);
            if (state.postStatus == PostStatus.success) {
              _titleTextEditingController.clear();
              _descTextEditingController.clear();
              _priority = null;
              _categoryid = null;
              _pickedDate = null;
              _pickedTime = null;
              Navigator.of(context).pop(context);
            }
          },
          child: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(
                      taskModel: TaskModel(
                          _titleTextEditingController.text,
                          _descTextEditingController.text,
                          DateTime.now(),
                          _pickedDate,
                          _categoryid,
                          _priority,
                          _switchValue)));
                }
              },
              icon: const Icon(
                size: 32,
                Icons.send,
                color: Colors.white54,
              )),
        ),
      ],
    );
  }
}
