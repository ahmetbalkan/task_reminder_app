import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_reminder_app/tools/extention.dart';

class IntroSliderPage1 extends StatefulWidget {
  const IntroSliderPage1({super.key});

  @override
  State<IntroSliderPage1> createState() => _IntroSliderPageState();
}

PageController _pageController = PageController();

class _IntroSliderPageState extends State<IntroSliderPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (() {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              color: context.primaryColor, width: 3)),
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
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        color: context.primaryColor,
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
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 62.h, top: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (() {}),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      width: 90.w,
                      height: 48.h,
                      child: Center(
                        child: Text(
                          "Skip",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 16.sp)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
