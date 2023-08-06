import 'package:flutter/material.dart';



Text buildMainDisplayText({required String enteredText}) {

  return Text(enteredText,
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.black54,
      )
  );
}

Text buildSecondaryDisplayTextBold({required String enteredText}) {
  return Text(enteredText,
    style: TextStyle(
        fontSize: 20.0,
        color: Colors.black54,
        fontWeight: FontWeight.w900,
    ),
  );
}

Text buildSecondaryDisplayText({required String enteredText}) {
  return Text(enteredText,
    style: TextStyle(
      fontSize: 20.0,
      color: Colors.black45,
    ),
  );
}

