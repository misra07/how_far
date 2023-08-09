import 'package:flutter/material.dart';

class basicElevatedBTN extends StatelessWidget {

  late String btnText;
  late VoidCallback onPressed;

  basicElevatedBTN({required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 24)),
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
      ),
      onPressed: onPressed,
      child: Text(btnText),
    );
  }
}