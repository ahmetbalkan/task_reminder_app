import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:task_reminder_app/bloc/app_start_blocs/forgot_pass_auth/forgotpass_auth_bloc.dart';
import 'package:task_reminder_app/tools/extention.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
final _formKey = GlobalKey<FormState>();
bool _obscureText = true;

class _ForgotPassState extends State<ForgotPassPage> {
  @override
  Widget build(BuildContext context) {
    final forgotBloc = BlocProvider.of<ForgotPassAuthBloc>(context);
    return SafeArea(
        child: BlocListener<ForgotPassAuthBloc, ForgotPassAuthState>(
      listener: (context, state) {
        if (state is SuccessForgotPassAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Row(
                children: [
                  Icon(FontAwesomeIcons.check),
                  Expanded(
                    child: Text(
                      'mailsend'.tr(),
                      style: context.fontStyleLato(Colors.white, 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is FailedForgotPassAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Row(
                children: [
                  Icon(FontAwesomeIcons.xmark),
                  Text(
                    'ForgotPasserrorSnackbar',
                  ),
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
            title: Text("forgotpass".tr()),
            centerTitle: true,
          ),
          backgroundColor: context.backgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/forgotpass.png",
                      width: 300,
                    ),
                    formMethod(),
                  ],
                ),
                ForgotPassButtonMethod(forgotBloc),
                SizedBox(
                  height: 100,
                )
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
          return 'emptyText'.tr();
        }
        if (!RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value)) {
          return 'mailerror'.tr();
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

  Widget ForgotPassButtonMethod(ForgotPassAuthBloc forgotBloc) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          width: double.infinity,
          child: BlocBuilder<ForgotPassAuthBloc, ForgotPassAuthState>(
            builder: (context, authstate) {
              return ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (authstate is LoadingForgotPassAuthState) {
                      } else {
                        forgotBloc.add(ForgotPassEmailEvent(email: email.text));
                      }
                    }
                  },
                  child: authstate is LoadingForgotPassAuthState
                      ? FadingText(
                          'loading'.tr(),
                          style: context.fontStyleLato(Colors.white, 14),
                        )
                      : Text("forgotpassbutton".tr()));
            },
          )),
    ]);
  }
}
