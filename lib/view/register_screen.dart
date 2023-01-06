import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_reminder_app/tools/extention.dart';
import 'package:task_reminder_app/view/forgotpass_screen.dart';
import 'package:task_reminder_app/view/login_screen.dart';
import 'package:task_reminder_app/view/register_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController mail = TextEditingController();
TextEditingController password2 = TextEditingController();
bool _obscureText = true;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleTextStyle: context.fontStyleLato(Colors.white, 24),
            title: Text("register".tr()),
            centerTitle: true,
          ),
          backgroundColor: context.backgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "mail".tr(),
                          style: context.fontStyleLato(Colors.white, 16),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextField(
                          autofocus: false,
                          cursorColor: context.primaryColor,
                          controller: mail,
                          cursorHeight: 25,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      mail.text = "";
                                    });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        FontAwesomeIcons.circleXmark,
                                        size: 20.0,
                                        color: context.primaryColor,
                                      ),
                                    ),
                                  )),
                              prefixIcon: Icon(FontAwesomeIcons.user,
                                  color: context.primaryColor),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: context.primaryColor)),
                              focusColor: context.primaryColor,
                              isDense: true,
                              errorText: "asd",
                              hintText: 'mailaddress'.tr(),
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "passwordtitle".tr(),
                          style: context.fontStyleLato(Colors.white, 16),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextField(
                          cursorColor: context.primaryColor,
                          controller: password2,
                          cursorHeight: 25,
                          obscureText: _obscureText,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {},
                          autofocus: false,
                          decoration: InputDecoration(
                              errorText: "asd",
                              labelStyle: TextStyle(
                                  color: context.primaryColor, fontSize: 14),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: context.primaryColor)),
                              focusColor: context.primaryColor,
                              prefixIcon: Icon(FontAwesomeIcons.key,
                                  color: context.primaryColor),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        _obscureText
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                        size: 20.0,
                                        color: context.primaryColor,
                                      ),
                                    ),
                                  )),
                              isDense: true,
                              hintText: 'password'.tr(),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: context.primaryColor))),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "passwordtitle".tr(),
                          style: context.fontStyleLato(Colors.white, 16),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextField(
                          cursorColor: context.primaryColor,
                          controller: password2,
                          cursorHeight: 25,
                          obscureText: _obscureText,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {},
                          autofocus: false,
                          decoration: InputDecoration(
                              errorText: "asd",
                              labelStyle: TextStyle(
                                  color: context.primaryColor, fontSize: 14),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: context.primaryColor)),
                              focusColor: context.primaryColor,
                              prefixIcon: Icon(FontAwesomeIcons.key,
                                  color: context.primaryColor),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        _obscureText
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                        size: 20.0,
                                        color: context.primaryColor,
                                      ),
                                    ),
                                  )),
                              isDense: true,
                              hintText: 'password'.tr(),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: context.primaryColor))),
                        ),
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: context.primaryColor,
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {},
                            child: Text(
                              "register".tr(),
                            ),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(children: <Widget>[
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "or".tr(),
                          style: context.fontStyleLato(Colors.white, 16),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ]),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: Image.asset("assets/google.png"),
                            style: TextButton.styleFrom(
                              side: BorderSide(
                                  color: context.primaryColor, width: 1),
                              foregroundColor: context.primaryColor,
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {},
                            label: Text(
                              "googleregister".tr(),
                            ),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: Image.asset("assets/apple.png"),
                            style: TextButton.styleFrom(
                              side: BorderSide(
                                  color: context.primaryColor, width: 1),
                              foregroundColor: context.primaryColor,
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {},
                            label: Text(
                              "appleregister".tr(),
                            ),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "haveaccount".tr(),
                            style: context.fontStyleLato(Colors.white, 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
