import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:task_reminder_app/bloc/app_start_blocs/login_auth/login_auth_bloc.dart';
import 'package:task_reminder_app/tools/extention.dart';
import 'package:task_reminder_app/view/forgotpass_screen.dart';
import 'package:task_reminder_app/view/register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
final _formKey = GlobalKey<FormState>();
bool _obscureText = true;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<LoginAuthBloc>(context);
    return SafeArea(
        child: BlocListener<LoginAuthBloc, LoginAuthState>(
      listener: (context, state) {
        if (state is SuccessLoginAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Success'),
            ),
          );
        }
        if (state is FailedLoginAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Row(
                children: [
                  Icon(Icons.dangerous),
                  Text('Kayıt Yapılamadı. Lütfen Tekrar Deneyiniz.'),
                ],
              ),
            ),
          );
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleTextStyle: context.fontStyleLato(Colors.white, 24),
            title: Text("login".tr()),
            centerTitle: true,
          ),
          backgroundColor: context.backgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Expanded(flex: 5, child: formMethod()),
                Expanded(
                  flex: 1,
                  child: loginButtonMethod(dataBloc),
                ),
                Expanded(
                  flex: 1,
                  child: orMethod(),
                ),
                Expanded(
                  flex: 1,
                  child: googleButtonMethod(),
                ),
                Expanded(
                  flex: 1,
                  child: AppleButtonMethod(),
                ),
                Expanded(
                  flex: 1,
                  child: RegisterButtonMethod(),
                ),
              ],
            ),
          )),
    ));
  }

  Widget formMethod() {
    return Form(
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
              height: 10.h,
            ),
            mailTextFieldMethod(),
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
            passwordTextFieldMethod(),
            forgotPassMethod(context),
          ]),
    );
  }

  Widget mailTextFieldMethod() {
    return TextFormField(
      autofocus: false,
      cursorColor: context.primaryColor,
      controller: email,
      cursorHeight: 25,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (!RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value)) {
          return 'Lütfen geçerli bir mail adresi giriniz.';
        }
        return null;
      },
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  email.text = "";
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

  Widget passwordTextFieldMethod() {
    return TextFormField(
      cursorColor: context.primaryColor,
      controller: password,
      cursorHeight: 25,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
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
        return null;
      },
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

  Widget forgotPassMethod(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPassPage(),
                    ));
              },
              child: Text(
                "forgotpass".tr(),
                style: context.fontStyleLato(context.primaryColor, 16),
              ))
        ]);
  }

  Widget loginButtonMethod(LoginAuthBloc dataBloc) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          width: double.infinity,
          child: BlocBuilder<LoginAuthBloc, LoginAuthState>(
            builder: (context, authstate) {
              return ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (authstate is LoadingLoginAuthState) {
                      } else {
                        dataBloc.add(LoginEmailPassEvent(
                            email: email.text, password: password.text));
                      }
                    }
                  },
                  child: authstate is LoadingLoginAuthState
                      ? FadingText(
                          'Loading...',
                          style: context.fontStyleLato(Colors.white, 14),
                        )
                      : Text("login".tr()));
            },
          )),
    ]);
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

  Column googleButtonMethod() {
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
            "googlelogin".tr(),
          ),
        ),
      ),
    ]);
  }

  Widget AppleButtonMethod() {
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
            "applelogin".tr(),
          ),
        ),
      ),
    ]);
  }

  Widget RegisterButtonMethod() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
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
              "donthaveaccount".tr(),
              style: context.fontStyleLato(Colors.white, 14),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "register2".tr(),
              style: context.fontStyleLato(Colors.grey, 14),
            ),
          ],
        ),
      ),
    );
  }
}
