import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:task_reminder_app/tools/extention.dart';
import 'package:task_reminder_app/view/before_login/forgotpass/forgotpass_screen.dart';
import 'package:task_reminder_app/view/before_login/login/login_screen.dart';
import '../../../bloc/app_start_blocs/register_auth/register_auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController _mail = TextEditingController();
TextEditingController _password1 = TextEditingController();
TextEditingController _password2 = TextEditingController();

final _formKey = GlobalKey<FormState>();
bool _obscureText = true;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<RegisterAuthBloc, RegisterAuthState>(
        listener: (context, state) {
          if (state is SuccessRegisterAuthState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Success'),
              ),
            );
          }
          if (state is FailedRegisterAuthState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  children: [
                    Icon(Icons.dangerous),
                    Text('registererrorSnackbar'.tr()),
                  ],
                ),
              ),
            );
          }
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "mail".tr(),
                              style: context.fontStyleLato(Colors.white, 16),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            mailTextfieldWidget(),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "passwordtitle".tr(),
                              style: context.fontStyleLato(Colors.white, 16),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            textfieldPassword1Widget(),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "passwordtitle".tr(),
                              style: context.fontStyleLato(Colors.white, 16),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            textfieldPassword2Widget(),
                            SizedBox(
                              height: 5.h,
                            ),
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
                              child: registerButtonMethod(_mail, _password2)),
                        ]),
                  ),
                  Expanded(
                    flex: 1,
                    child: orMethod(),
                  ),
                  Expanded(
                    flex: 1,
                    child: googleButtonWidget(),
                  ),
                  Expanded(
                    flex: 1,
                    child: appleButtonWidget(),
                  ),
                  Expanded(
                    flex: 1,
                    child: loginButtonWidget(),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget mailTextfieldWidget() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'emptyText'.tr();
        }
        if (!RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value)) {
          return 'mailerror'.tr();
        }

        return null;
      },
      autofocus: false,
      cursorColor: context.primaryColor,
      controller: _mail,
      cursorHeight: 25,
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _mail.text = "";
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
          prefixIcon: Icon(FontAwesomeIcons.user, color: context.primaryColor),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.primaryColor)),
          focusColor: context.primaryColor,
          isDense: true,
          hintText: 'mailaddress'.tr(),
          border: const OutlineInputBorder(borderSide: BorderSide())),
    );
  }

  Widget textfieldPassword1Widget() {
    return TextFormField(
      cursorColor: context.primaryColor,
      controller: _password1,
      cursorHeight: 25,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'emptyText'.tr();
        }
        if (!RegExp("(?=.*[a-zA-Z])").hasMatch(value)) {
          return "lowercasedesc".tr();
        }
        if (!RegExp("(?=.*[A-Z])").hasMatch(value)) {
          return "uppercasedesc".tr();
        }
        if (!RegExp((r'\d')).hasMatch(value)) {
          return "digitsec".tr();
        }
        if (value.length < 8) {
          return "8digit".tr();
        }
        return null;
      },
      autofocus: false,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: context.primaryColor, fontSize: 14),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.primaryColor)),
          focusColor: context.primaryColor,
          prefixIcon: Icon(FontAwesomeIcons.key, color: context.primaryColor),
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
              borderSide: BorderSide(color: context.primaryColor))),
    );
  }

  Widget textfieldPassword2Widget() {
    return TextFormField(
      cursorColor: context.primaryColor,
      controller: _password2,
      cursorHeight: 25,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (!RegExp("(?=.*[a-zA-Z])").hasMatch(value)) {
          return "lowercasedesc".tr();
        }
        if (!RegExp("(?=.*[A-Z])").hasMatch(value)) {
          return "uppercasedesc".tr();
        }
        if (!RegExp((r'\d')).hasMatch(value)) {
          return "digitsec".tr();
        }
        if (value.length < 8) {
          return "8digit".tr();
        }
        print(value);
        print(_password1.text);
        if (_password1.text != value) {
          return "passMatch".tr();
        }
        return null;
      },
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: context.primaryColor, fontSize: 14),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.primaryColor)),
          focusColor: context.primaryColor,
          prefixIcon: Icon(FontAwesomeIcons.key, color: context.primaryColor),
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
              borderSide: BorderSide(color: context.primaryColor))),
    );
  }

  Widget registerButtonMethod(controllerEmail, controllerPass) {
    final registerBloc = BlocProvider.of<RegisterAuthBloc>(context);

    return BlocBuilder<RegisterAuthBloc, RegisterAuthState>(
      builder: (context, authstate) {
        return ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: context.primaryColor,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (authstate is LoadingRegisterAuthState) {
                } else {
                  registerBloc.add(LoginEmailPassEvent(
                      email: controllerEmail.text,
                      password: controllerPass.text));
                }
              }
            },
            child: authstate is LoadingRegisterAuthState
                ? FadingText(
                    'loading'.tr(),
                    style: context.fontStyleLato(Colors.white, 14),
                  )
                : Text("register".tr()));
      },
    );
  }

  Widget orMethod() {
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

  Widget googleButtonWidget() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: Image.asset("assets/google.png"),
          style: TextButton.styleFrom(
            side: BorderSide(color: context.primaryColor, width: 1),
            foregroundColor: context.primaryColor,
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () {},
          label: Text(
            "googleregister".tr(),
          ),
        ),
      ),
    ]);
  }

  Widget appleButtonWidget() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: Image.asset("assets/apple.png"),
          style: TextButton.styleFrom(
            side: BorderSide(color: context.primaryColor, width: 1),
            foregroundColor: context.primaryColor,
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () {},
          label: Text(
            "appleregister".tr(),
          ),
        ),
      ),
    ]);
  }

  Widget loginButtonWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
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
    );
  }
}
