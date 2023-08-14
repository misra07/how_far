import 'package:flutter/cupertino.dart';
import 'constants.dart';

class BasicText extends StatelessWidget {
  final String text;
  final Color? color;

  const BasicText({super.key, required this.text, this.color});

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