import 'package:flutter/material.dart';

Widget buildHeaderText(text1,text2,text3){
  return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style:const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        Text(
          text2,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        Text(
          text3,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ],
    );
}