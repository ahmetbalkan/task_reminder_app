import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../bloc/app_start_blocs/intropage_bloc/intropage_bloc.dart';
import '../../tools/extention.dart';
import 'login/login_screen.dart';

class IntroSliderPage extends StatefulWidget {
  const IntroSliderPage({super.key});

  @override
  State<IntroSliderPage> createState() => _IntroSliderPageState();
}

PageController _pageController = PageController();

class _IntroSliderPageState extends State<IntroSliderPage> {
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      context
          .read<IntroPageBloc>()
          .add(SetIntroCountEvent(setCount: _pageController.page!));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: context.backgroundColor,
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(flex: 10, child: skipButtonWidget(context)),
            Expanded(
              flex: 70,
              child: centerPageViewWidget(context),
            ),
            Expanded(
              flex: 10,
              child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: context.primaryColor)),
            ),
            Expanded(flex: 7, child: bottomButtonsWidget(context)),
            const Expanded(flex: 5, child: Center()),
          ])),
    );
  }

  Row skipButtonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(
          flex: 8,
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: (() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false);
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                textAlign: TextAlign.center,
                "skip".tr(),
                style: context.fontStyleLato(Colors.white, 18),
              ),
            ),
          ),
        ),
      ],
    );
  }

  PageView centerPageViewWidget(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        Column(
          children: [
            Expanded(
                flex: 6,
                child: Image.asset("assets/intropage/enterslider1.png")),
            Expanded(
                flex: 1,
                child: Text("intro1title".tr(),
                    textAlign: TextAlign.center,
                    style: context.fontStyleLato(Colors.white, 32.sp))),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                      textAlign: TextAlign.center,
                      "intro1desc".tr(),
                      style: context.fontStyleLato(Colors.white, 16.sp)),
                )),
          ],
        ),
        Column(
          children: [
            Expanded(
                flex: 6,
                child: Image.asset("assets/intropage/enterslider1.png")),
            Expanded(
                flex: 1,
                child: Text("intro2title".tr(),
                    textAlign: TextAlign.center,
                    style: context.fontStyleLato(Colors.white, 32.sp))),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                      textAlign: TextAlign.center,
                      "intro2desc".tr(),
                      style: context.fontStyleLato(Colors.white, 16.sp)),
                )),
          ],
        ),
        Column(
          children: [
            Expanded(
                flex: 6,
                child: Image.asset("assets/intropage/enterslider1.png")),
            Expanded(
                flex: 1,
                child: Text("intro3title".tr(),
                    textAlign: TextAlign.center,
                    style: context.fontStyleLato(Colors.white, 32.sp))),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                      textAlign: TextAlign.center,
                      "intro3desc".tr(),
                      style: context.fontStyleLato(Colors.white, 16.sp)),
                )),
          ],
        ),
      ],
    );
  }

  Row bottomButtonsWidget(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        BlocBuilder<IntroPageBloc, IntroPageState>(
          builder: (context, state) {
            return state.getCount == 0.0
                ? Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.primaryMaterialColor.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: BlocBuilder<IntroPageBloc, IntroPageState>(
                        builder: (context, state) {
                          return Text(
                            "Back",
                            style: context.fontStyleLato(Colors.white, 14.sp),
                          );
                        },
                      )),
                    ),
                  )
                : Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        _pageController.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInQuad);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: BlocBuilder<IntroPageBloc, IntroPageState>(
                          builder: (context, state) {
                            return Text(
                              "Back",
                              style: context.fontStyleLato(Colors.white, 14.sp),
                            );
                          },
                        )),
                      ),
                    ),
                  );
          },
        ),
        const Spacer(
          flex: 1,
        ),
        BlocBuilder<IntroPageBloc, IntroPageState>(
          builder: (context, state) {
            return state.getCount == 2.0
                ? Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.primaryMaterialColor.shade900,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: BlocBuilder<IntroPageBloc, IntroPageState>(
                          builder: (context, state) {
                            return Text(
                              "Let's Start",
                              style: context.fontStyleLato(Colors.white, 14.sp),
                            );
                          },
                        )),
                      ),
                    ),
                  )
                : Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInQuad);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: BlocBuilder<IntroPageBloc, IntroPageState>(
                          builder: (context, state) {
                            return Text(
                              "Next",
                              style: context.fontStyleLato(Colors.white, 14.sp),
                            );
                          },
                        )),
                      ),
                    ),
                  );
          },
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
