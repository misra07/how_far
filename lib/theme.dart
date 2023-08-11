import 'package:flutter/material.dart';
import 'package:how_far/colors.dart';

@immutable
class AppTheme{
  static const colors = HFColors();
  static const buttons = BTNColors();

  const AppTheme._();

  static ThemeData define(){
    return ThemeData (
        fontFamily: 'SFRegular',
        primaryColor: Color(0xff9C8898),
    focusColor: Color(0xffB9475F),

    //lightShadeColor: Color(0xffF7F8F7);
    // lightAccentColor: Color(0xffA4C3CE);
    // primaryColor: Color(0xff9C8898);
    // darkAccentColor: Color(0xffB9475F);
    // darkShadeColor: Color(0xff2D304E);
    );
  }
}