import 'package:flutter/material.dart';
import 'package:how_far/constants.dart';



Text buildMainDisplayText({required String enteredText}) {

  return Text(enteredText,
      style: TextStyle(
        fontSize: 20.0,
        color: kColorBlackFancy,
      )
  );
}

Text buildSecondaryDisplayTextBold({required String enteredText}) {
  return Text(enteredText,
    style: TextStyle(
        fontSize: 15.0,
        color: kColorBlackFancy,
        fontWeight: FontWeight.w900,
    ),
  );
}

Text buildSecondaryDisplayText({required String enteredText}) {
  return Text(enteredText,
    style: TextStyle(
      fontSize: 20.0,
      color: kColorBlackFancy,
    ),
  );
}

