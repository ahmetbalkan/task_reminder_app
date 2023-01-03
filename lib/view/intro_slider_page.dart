import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_reminder_app/tools/Color.dart';

import '../widget/intro_page/intro_pointer_widget.dart';

class IntroSliderPage extends StatefulWidget {
  const IntroSliderPage({super.key});

  @override
  State<IntroSliderPage> createState() => _IntroSliderPageState();
}

PageController _pageController = PageController();

class _IntroSliderPageState extends State<IntroSliderPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorClass.BackgroundColor,
          appBar: AppBar(
            backgroundColor: ColorClass.BackgroundColor,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Skip",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: ColorClass.PrimaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold)),
                    )),
              )
            ],
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(controller: _pageController, children: [
                  Column(children: [
                    Image.asset("assets/intropage/enterslider1.png"),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Container(
                        child: Text(
                          "Manage your tasks",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: 42.h, left: 42.h, top: 42.h),
                      child: Text(
                        textAlign: TextAlign.center,
                        "You can easily manage all of your daily tasks in DoMe for free",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                      ),
                    ),
                  ]),
                  Column(children: [
                    Image.asset("assets/intropage/enterslider1.png"),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Container(
                        child: Text(
                          "Manage your tasks",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: 42.h, left: 42.h, top: 42.h),
                      child: Text(
                        textAlign: TextAlign.center,
                        "You can easily manage all of your daily tasks in DoMe for free",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                      ),
                    ),
                  ]),
                  Column(children: [
                    Image.asset("assets/intropage/enterslider1.png"),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Container(
                        child: Text(
                          "Manage your tasks",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: 42.h, left: 42.h, top: 42.h),
                      child: Text(
                        textAlign: TextAlign.center,
                        "You can easily manage all of your daily tasks in DoMe for free",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                      ),
                    ),
                  ]),
                  Column(children: [
                    Image.asset("assets/intropage/enterslider1.png"),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Container(
                        child: Text(
                          "Manage your tasks",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: 42.h, left: 42.h, top: 42.h),
                      child: Text(
                        textAlign: TextAlign.center,
                        "You can easily manage all of your daily tasks in DoMe for free",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                      ),
                    ),
                  ]),
                  Column(children: [
                    Image.asset("assets/intropage/enterslider1.png"),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Container(
                        child: Text(
                          "Manage your tasks",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: 42.h, left: 42.h, top: 42.h),
                      child: Text(
                        textAlign: TextAlign.center,
                        "You can easily manage all of your daily tasks in DoMe for free",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                      ),
                    ),
                  ]),
                ]),
              ),
              SizedBox(
                height: 150.h,
                child: Pointer(_pageController),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (() {
                        _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            border: Border.all(
                                color: ColorClass.PrimaryColor, width: 3)),
                        width: 90.w,
                        height: 48.h,
                        child: Center(
                          child: Text(
                            "Back",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 16.sp)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: ColorClass.PrimaryColor,
                        ),
                        width: 90.w,
                        height: 48.h,
                        child: Center(
                          child: Text("Next",
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 16.sp))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
