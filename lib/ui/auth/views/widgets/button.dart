import 'package:flutter/material.dart';

Widget customButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      // backgroundColor: Color.fromRGBO(141, 96, 255, 1),
      backgroundColor: Colors.deepPurpleAccent,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300,fontSize: 16),
    ),
  );
}
