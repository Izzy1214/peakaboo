// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget buildShowUserNameAndEmail({String? text, IconData? icon}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    height: 100,
    decoration: BoxDecoration(
      color: Colors.purpleAccent,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text!,
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}
