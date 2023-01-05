import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:task_reminder_app/tools/extention.dart';
import 'package:task_reminder_app/view/login_screen.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController mail = TextEditingController();
TextEditingController password1 = TextEditingController();
TextEditingController password2 = TextEditingController();

bool _obscureText = true;

class _ForgotPassPageState extends State<ForgotPassPage> {
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
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                FontAwesomeIcons.angleLeft,
                                size: 35,
                              ),
                            )),
                        Expanded(
                          flex: 8,
                          child: Text(
                            "register".tr(),
                            textAlign: TextAlign.center,
                            style: context.fontStyleLato(Colors.white, 32),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      "registerdesc".tr(),
                      style: context.fontStyleLatoFontWeigt(
                          Colors.white, 12, FontWeight.w100),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 8,
            child: formMethod(),
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
              flex: 15,
              child: Center(
                  child: Image.asset("assets/intropage/enterslider1.png")),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
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
}
