import 'package:flutter/material.dart';



Text buildMainDisplayText({required String enteredText}) {

  return Text(enteredText,
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.black54,
      )
  );
}