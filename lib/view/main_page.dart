import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:task_reminder_app/model/category.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/category_isar_repository.dart';
import 'package:task_reminder_app/tools/extention.dart';
import '../bloc/categories_bloc/category_bloc.dart';
import '../bloc/test_bloc/test_bloc.dart';
import '../locator.dart';
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
late TextEditingController _catNameTextEditingController;
late TextEditingController _startDateController;
late TextEditingController _endDateController;
final _formKey = GlobalKey<FormState>();

Color _screenPickerColor = Colors.red;
IconData? _icondata = Icons.assignment_late_outlined;
DateTime? _startDate;
DateTime? _endDate;
int? _categoryid;
int? _priority;
bool _switchValue = false;

var _categoryRepository = locator.get<CategoryIsarRepository>();

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
    _descTextEditingController = TextEditingController();
    _titleTextEditingController = TextEditingController();
    _catNameTextEditingController = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
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
          BlocListener<TestBloc, TestState>(
            listener: (context, state) {},
          );
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
                height: ScreenUtil().screenHeight / 1.5,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "add-task".tr(),
                                    style: context.fontStyleLatoFontWeigt(
                                        Colors.white, 20, FontWeight.bold),
                                  ),
                                  BlocListener<TestBloc, TestState>(
                                    listener: (context, state) {
                                      if (state is AddSuccessState) {
                                        _titleTextEditingController.clear();
                                        _descTextEditingController.clear();
                                        _priority = null;
                                        _categoryid = null;
                                        _startDate = null;
                                        _endDate = null;
                                        Navigator.of(context).pop(context);
                                      }
                                    },
                                    child: TextButton.icon(
                                      icon: const Icon(
                                        size: 22,
                                        Icons.add,
                                        color: Colors.white54,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: context.primaryColor
                                              .withOpacity(0.4)),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<TestBloc>(context)
                                              .add(AddTestEvent(
                                                  taskModel: TaskModel(
                                                      _titleTextEditingController
                                                          .text,
                                                      _descTextEditingController
                                                          .text,
                                                      DateTime.now(),
                                                      DateTime.now(),
                                                      _categoryid,
                                                      _priority,
                                                      _switchValue,
                                                      true)));
                                        }
                                      },
                                      label: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Text(
                                          'Oluştur',
                                          style: context.fontStyleLato(
                                              Colors.white, 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(flex: 3, child: titleTextFieldMethod(context)),
                        Expanded(flex: 5, child: descTextfieldMethod(context)),
                        Expanded(flex: 3, child: dateTimePickerMethod(context)),
                        Expanded(
                            flex: 3, child: categoryAndPriorityMethod(context)),
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
      maxLines: 5,
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

  Widget dateTimePickerMethod(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 15,
            child: TextFormField(
              controller: _startDateController,
              readOnly: true,
              autofocus: false,
              onTap: () async {
                _startDate = await showOmniDateTimePicker(
                  context: context,
                  primaryColor: context.primaryColor,
                  backgroundColor: context.backgroundSoftColor,
                  calendarTextColor: Colors.white,
                  tabTextColor: Colors.white,
                  unselectedTabBackgroundColor: context.backgroundSoftColor,
                  buttonTextColor: Colors.white,
                  timeSpinnerTextStyle:
                      const TextStyle(color: Colors.white70, fontSize: 18),
                  timeSpinnerHighlightedTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 24),
                  is24HourMode: true,
                  isShowSeconds: false,
                  startFirstDate:
                      DateTime(1600).subtract(const Duration(days: 3652)),
                  startLastDate: DateTime.now().add(
                    const Duration(days: 3652),
                  ),
                  borderRadius: const Radius.circular(16),
                );
              },
              cursorColor: context.primaryColor,
              cursorHeight: 25,
              keyboardType: TextInputType.datetime,
              /* validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'emptyText'.tr();
                }
                return null;
              },*/
              decoration: InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.solidCalendarPlus,
                      color: context.primaryColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor)),
                  focusColor: context.primaryColor,
                  isDense: true,
                  hintText: "Başlangıç",
                  hintStyle: context.fontStyleLato(Colors.grey, 16),
                  border: const OutlineInputBorder(borderSide: BorderSide())),
            )),
        Spacer(
          flex: 1,
        ),
        Expanded(
            flex: 15,
            child: TextFormField(
              controller: _endDateController,
              readOnly: true,
              onTap: () async {
                _startDate = await showOmniDateTimePicker(
                  context: context,
                  primaryColor: context.primaryColor,
                  backgroundColor: context.backgroundSoftColor,
                  calendarTextColor: Colors.white,
                  tabTextColor: Colors.white,
                  unselectedTabBackgroundColor: context.backgroundSoftColor,
                  buttonTextColor: Colors.white,
                  timeSpinnerTextStyle:
                      const TextStyle(color: Colors.white70, fontSize: 18),
                  timeSpinnerHighlightedTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 24),
                  is24HourMode: true,
                  isShowSeconds: false,
                  startFirstDate:
                      DateTime(1600).subtract(const Duration(days: 3652)),
                  startLastDate: DateTime.now().add(
                    const Duration(days: 3652),
                  ),
                  borderRadius: const Radius.circular(16),
                );
              },
              autofocus: false,
              cursorColor: context.primaryColor,
              cursorHeight: 25,
              keyboardType: TextInputType.datetime,
              /* validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'emptyText'.tr();
                }
                return null;
              },*/
              decoration: InputDecoration(
                  hintStyle: context.fontStyleLato(Colors.grey, 16),
                  prefixIcon: Icon(FontAwesomeIcons.solidCalendarMinus,
                      color: context.primaryColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor)),
                  focusColor: context.primaryColor,
                  isDense: true,
                  hintText: "Bitiş",
                  border: const OutlineInputBorder(borderSide: BorderSide())),
            ))
      ],
    );
  }

  Widget categoryAndPriorityMethod(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 15,
            child: TextFormField(
              controller: _startDateController,
              readOnly: true,
              autofocus: false,
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        insetPadding: const EdgeInsets.all(8.0),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "choise-add-category".tr(),
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
                                  child: StreamBuilder<List<CategoryModel>>(
                                      stream:
                                          _categoryRepository.listenCategory(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  "assets/emptypagevector.png",
                                                ),
                                                Text("empty-category".tr(),
                                                    style:
                                                        context.fontStyleLato(
                                                            Colors.white, 16)),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return GridView.builder(
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  _categoryid = index;

                                                  Navigator.pop(context);
                                                },
                                                onLongPress: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          "Categori Siliniyor",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        content: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            "Bu kategoriyi silmeniz halinde buna bağlı tüm görevlerde silinicektir onaylıyor musunuz ?"),
                                                        actions: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Expanded(
                                                                flex: 5,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      minimumSize:
                                                                          const Size.fromHeight(
                                                                              50),
                                                                      backgroundColor:
                                                                          context
                                                                              .primaryColor),
                                                                  onPressed:
                                                                      () {
                                                                    context
                                                                        .read<
                                                                            CategoryBloc>()
                                                                        .add(DeleteCategoryEvent(snapshot
                                                                            .data![index]
                                                                            .id));
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "Sil",
                                                                  ),
                                                                ),
                                                              ),
                                                              Spacer(
                                                                flex: 1,
                                                              ),
                                                              Expanded(
                                                                flex: 5,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      minimumSize:
                                                                          const Size.fromHeight(
                                                                              50),
                                                                      backgroundColor:
                                                                          context
                                                                              .primaryColor),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "Kapat",
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Color(snapshot
                                                              .data![index]
                                                              .categoryColor),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          FaIcon(
                                                            IconData(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .icon,
                                                                fontFamily:
                                                                    'MaterialIcons'),
                                                            size: 40.h,
                                                            color: context
                                                                .backgroundSoftColor,
                                                          ),
                                                          Text(
                                                            (snapshot
                                                                    .data![
                                                                        index]
                                                                    .categoryName)
                                                                .toString(),
                                                            style: context
                                                                .fontStyleLato(
                                                                    context
                                                                        .backgroundSoftColor,
                                                                    16),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              );
                                            },
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                            ),
                                          );
                                        }
                                      }),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Uzun basarak kategorileri silebilirsiniz."),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size.fromHeight(50),
                                                backgroundColor:
                                                    context.primaryColor),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text('Kategori Ekle'),
                                                      content: Container(
                                                          height: ScreenUtil()
                                                                  .screenHeight /
                                                              4,
                                                          width: ScreenUtil()
                                                              .screenWidth,
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                autofocus:
                                                                    false,
                                                                cursorColor: context
                                                                    .primaryColor,
                                                                controller:
                                                                    _catNameTextEditingController,
                                                                cursorHeight:
                                                                    30,
                                                                style: context
                                                                    .fontStyleLato(
                                                                        Colors
                                                                            .white,
                                                                        18),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                /*  validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'emptyText'
                                                                        .tr();
                                                                  }
                                                                  return null;
                                                                },*/
                                                                decoration: InputDecoration(
                                                                    filled: true,
                                                                    fillColor: context.backgroundSoftColor,
                                                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.primaryColor)),
                                                                    suffixIcon: GestureDetector(
                                                                        onTap: () {
                                                                          _titleTextEditingController.text =
                                                                              "";
                                                                        },
                                                                        child: Container(
                                                                          color:
                                                                              Colors.transparent,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Icon(
                                                                              FontAwesomeIcons.deleteLeft,
                                                                              size: 25.0,
                                                                              color: context.primaryColor,
                                                                            ),
                                                                          ),
                                                                        )),
                                                                    focusColor: context.primaryColor,
                                                                    isDense: true,
                                                                    hintText: "add-category".tr(),
                                                                    hintStyle: context.fontStyleLato(Colors.white, 14),
                                                                    border: const UnderlineInputBorder(borderSide: BorderSide())),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 8,
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          minimumSize: const Size.fromHeight(
                                                                              50),
                                                                          backgroundColor:
                                                                              context.primaryColor),
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: ScreenUtil().screenHeight / 1.5,
                                                                                  width: ScreenUtil().screenWidth,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(6),
                                                                                    child: Card(
                                                                                      elevation: 2,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          ColorPicker(
                                                                                            actionButtons: ColorPickerActionButtons(closeButton: true, dialogActionButtons: true),
                                                                                            color: _screenPickerColor,
                                                                                            onColorChanged: (value) {
                                                                                              setState(() {
                                                                                                _screenPickerColor = value;
                                                                                              });
                                                                                            },
                                                                                            width: 44,
                                                                                            height: 44,
                                                                                            borderRadius: 22,
                                                                                            heading: Text(
                                                                                              'choisecolor'.tr(),
                                                                                              style: Theme.of(context).textTheme.headlineSmall,
                                                                                            ),
                                                                                            subheading: Text(
                                                                                              'choisecolor'.tr(),
                                                                                              style: Theme.of(context).textTheme.titleSmall,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "choisecolor"
                                                                            .tr(),
                                                                        style: context.fontStyleLato(
                                                                            Colors.white,
                                                                            14),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 8,
                                                                    child:
                                                                        ElevatedButton
                                                                            .icon(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .select_all),
                                                                      style: ElevatedButton.styleFrom(
                                                                          minimumSize: const Size.fromHeight(
                                                                              50),
                                                                          backgroundColor:
                                                                              context.primaryColor),
                                                                      onPressed:
                                                                          () async {
                                                                        _icondata = await FlutterIconPicker.showIconPicker(
                                                                            context,
                                                                            iconPackModes: [
                                                                              IconPack.material
                                                                            ]);
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      label:
                                                                          Text(
                                                                        "choiseicon"
                                                                            .tr(),
                                                                        style: context.fontStyleLato(
                                                                            Colors.white,
                                                                            14),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    minimumSize:
                                                                        const Size.fromHeight(
                                                                            50),
                                                                    backgroundColor:
                                                                        context
                                                                            .primaryColor),
                                                                onPressed: () {
                                                                  context.read<CategoryBloc>().add(AddCategoryEvent(
                                                                      categoryModel: CategoryModel(
                                                                          _catNameTextEditingController
                                                                              .text,
                                                                          _screenPickerColor
                                                                              .value,
                                                                          _icondata!
                                                                              .codePoint)));
                                                                },
                                                                child: Text(
                                                                  "add-new-category"
                                                                      .tr(),
                                                                  style: context
                                                                      .fontStyleLato(
                                                                          Colors
                                                                              .white,
                                                                          14),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    );
                                                  });
                                            },
                                            child: Text(
                                              "add-category".tr(),
                                              style: context.fontStyleLato(
                                                  Colors.white, 18),
                                            ),
                                          ),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size.fromHeight(50),
                                                backgroundColor:
                                                    context.primaryColor),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "cancel".tr(),
                                              style: context.fontStyleLato(
                                                  Colors.white, 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      );
                    });
              },
              cursorColor: context.primaryColor,
              cursorHeight: 25,
              keyboardType: TextInputType.datetime,
              /* validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'emptyText'.tr();
                }
                return null;
              },*/
              decoration: InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.solidCalendarPlus,
                      color: context.primaryColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor)),
                  focusColor: context.primaryColor,
                  isDense: true,
                  hintText: "Kategori",
                  hintStyle: context.fontStyleLato(Colors.grey, 16),
                  border: const OutlineInputBorder(borderSide: BorderSide())),
            )),
        Spacer(
          flex: 1,
        ),
        Expanded(
            flex: 15,
            child: TextFormField(
              controller: _endDateController,
              readOnly: true,
              onTap: () async {
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
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: context.backgroundsoft,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(6))),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  const Icon(FontAwesomeIcons
                                                      .solidFlag),
                                                  Text((index + 1).toString()),
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
                              ],
                            )),
                      );
                    });
              },
              autofocus: false,
              cursorColor: context.primaryColor,
              cursorHeight: 25,
              keyboardType: TextInputType.datetime,
              /*  validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'emptyText'.tr();
                }
                return null;
              },*/
              decoration: InputDecoration(
                  hintStyle: context.fontStyleLato(Colors.grey, 16),
                  prefixIcon: Icon(FontAwesomeIcons.solidCalendarMinus,
                      color: context.primaryColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor)),
                  focusColor: context.primaryColor,
                  isDense: true,
                  hintText: "Öncelik",
                  border: const OutlineInputBorder(borderSide: BorderSide())),
            ))
      ],
    );
  }

  Widget sendAndNotificationMethod(BuildContext errorcontext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            ),
          ],
        ),
        BlocListener<TestBloc, TestState>(
          listener: (context, state) {
            if (state is AddSuccessState) {
              _titleTextEditingController.clear();
              _descTextEditingController.clear();
              _priority = null;
              _categoryid = null;
              _startDate = null;
              _endDate = null;
              Navigator.of(context).pop(context);
            }
          },
          child: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<TestBloc>().add(AddTestEvent(
                      taskModel: TaskModel(
                          _titleTextEditingController.text,
                          _descTextEditingController.text,
                          DateTime.now(),
                          DateTime.now(),
                          _categoryid,
                          _priority,
                          _switchValue,
                          true)));
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
