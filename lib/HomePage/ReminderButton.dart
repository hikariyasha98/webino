import 'package:flutter/material.dart';
import 'package:webino/StartPage/StartPage.dart';
import 'package:webino/ReminderPage/Reminder.dart';

import '../my_flutter_app_icons.dart';

class Reminderbutton extends StatefulWidget {
  const Reminderbutton({
    Key? key,
    required this.token,
    required this.pT,
    required this.pB,
    required this.pR,
    required this.pL,
    required this.size,
  }) : super(key: key);
  final String token;
  final double pT, pB, pR, pL, size;
  @override
  _ReminderbuttonState createState() => _ReminderbuttonState();
}

class _ReminderbuttonState extends State<Reminderbutton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.token == "Guest" ||
              widget.token.toString().isEmpty ||
              widget.token.toString() == 'null'
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StartPage(
                    tokenAB: widget.token,
                  ),
                ),
              );
            }
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReminderPage(),
                ),
              );
            },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
            top: widget.pT,
            bottom: widget.pB,
            right: widget.pR,
          ),
          child: Container(
            child: Icon(
              MyFlutterApp.time,
              color: Colors.white,
              size: widget.size,
            ),
          ),
        ),
      ),
    );
  }
}
