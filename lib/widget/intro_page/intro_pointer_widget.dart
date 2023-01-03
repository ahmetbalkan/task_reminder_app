import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_reminder_app/tools/Color.dart';

class Pointer extends StatelessWidget {
  const Pointer(
    controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorClass.BackgroundColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(top: 50.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                width: 26.28.w,
                height: 5.h,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                width: 26.28.w,
                height: 5.h,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                width: 26.28.w,
                height: 5.h,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                width: 26.28.w,
                height: 5.h,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                width: 26.28.w,
                height: 5.h,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
