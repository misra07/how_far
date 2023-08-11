import 'package:flutter/cupertino.dart';
import 'constants.dart';

class basicText extends StatelessWidget {
  late String text;
  late Color? color;

  basicText({required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        fontSize: 20.00,
        fontWeight: FontWeight.w500,
        color: color ?? kColorDarkShade,
      ),);
  }
}