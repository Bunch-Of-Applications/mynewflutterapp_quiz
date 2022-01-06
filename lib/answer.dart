import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final Function answerTap;

  Answer({this.answerText, this.answerColor, this.answerTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        // color: Colors.lime,
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: answerColor,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Text(
          answerText,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
