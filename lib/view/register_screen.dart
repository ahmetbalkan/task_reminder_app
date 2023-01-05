import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:task_reminder_app/tools/extention.dart';
import 'package:task_reminder_app/view/login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController mail = TextEditingController();
TextEditingController password1 = TextEditingController();
TextEditingController password2 = TextEditingController();

bool _obscureText = true;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicHeight(0.02)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Icon(FontAwesomeIcons.circleLeft)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "register".tr(),
                            style: context.fontStyleLato(Colors.white, 32),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      "registerdesc".tr(),
                      style: context.fontStyleLatoFontWeigt(
                          Colors.white, 16, FontWeight.w100),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 8,
            child: formMethod(),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: orMethod(context),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: googleButtonMethod(context),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: appleButtonMethod(context),
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 2,
            child: registerButton(context),
          ),
        ]),
      ),
    );
  }

  Padding formMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
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
                              child: Icon(
                                FontAwesomeIcons.circleXmark,
                                size: 20.0,
                                color: context.primaryColor,
                              )),
                          prefixIcon: Icon(FontAwesomeIcons.user,
                              color: context.primaryColor),
                          labelStyle: TextStyle(
                              color: context.primaryColor, fontSize: 14),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.primaryColor)),
                          focusColor: context.primaryColor,
                          isDense: true,
                          labelText: 'mailaddress'.tr(),
                          border: OutlineInputBorder(borderSide: BorderSide())),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'emptytext'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
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
                              child: Icon(
                                _obscureText
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 20.0,
                                color: context.primaryColor,
                              )),
                          isDense: true,
                          labelText: 'password'.tr(),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.primaryColor))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'emptytext'.tr();
                        }
                        if (value.length < 8) {
                          return 'Bunu koyaman guzum'.tr();
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
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
                              child: Icon(
                                _obscureText
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 20.0,
                                color: context.primaryColor,
                              )),
                          isDense: true,
                          labelText: 'password2'.tr(),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.primaryColor))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'emptytext'.tr();
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: context.primaryColor,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: Text(
                          "login".tr(),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding googleButtonMethod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: Image.asset("assets/google.png"),
          label: Text(
            "googlelogin".tr(),
          ),
          style: TextButton.styleFrom(
            foregroundColor: context.primaryColor,
            side: BorderSide(color: context.primaryColor, width: 1),
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Padding appleButtonMethod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: Image.asset("assets/apple.png"),
          label: Text(
            "applelogin".tr(),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(color: context.primaryColor, width: 1),
            foregroundColor: context.primaryColor,
            minimumSize: const Size.fromWidth(40),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Padding orMethod(BuildContext context) {
    return Padding(
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
    );
  }

  SizedBox registerButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        },
        child: Text(
          "donthaveaccount".tr(),
          style: context.fontStyleLato(context.primaryColor, 14),
        ),
      ),
    );
  }
}
