import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

bool _switchValue = false;

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoSwitch(
        value: _switchValue,
        activeColor: CupertinoColors.activeBlue,
        onChanged: (value) {
          setState(() {
            _switchValue = value;
          });
        },
      ),
    );
  }
}
