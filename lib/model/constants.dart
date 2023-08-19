import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String kFSAkey = '181a1f7308714687b520b4a4fba216b7';
final  Uri kFSAUrl = Uri.parse('https://api.fuelsa.co.za/exapi/fuel/current');

const double kDefaultElevation = 24.0;

List<Widget> kLocationList = [
  const Center(child: Text('Inland',)),
  const Center(child: Text('Coast')),
];
int kLocationListIndex = 0;
int kFuelTypeListIndex = 1;
int kFuelGradeListIndex = 0;

List<Widget> kFuelTypeList = [
  const Center(child: Text('diesel')),
  const Center(child: Text('petrol')),
];
List<Widget> kPetrolList = [
  const Center(child: Text('95 unleaded'),),
  const Center(child: Text('93 unleaded'),),

];
List<Widget> kDieselList = [
  const Center(child: Text('50 PPM'),),
  const Center(child: Text('500 PPM'),),
];


const Color kColorBlack = Color(0xff252525);
const Color kColorBlackFancy = Color(0xff020122);
const Color kColorWhite =  Color(0xffdedede);
const Color kColorWhiteFancy =  Color(0xffcdcdcd);

const Color kColorLightShade = Color(0xffF7F8F7);
const Color kColorLightAccent =  Color(0xffA4C3CE);
const Color kColorPrimary =  Color(0xff9C8898);
const Color kColorDarkAccent =  Color(0xffB9475F);
const Color kColorDarkShade =  Color(0xff2D304E);

const Color kBtnColorDefault =  Color(0xff999999);
const Color kBtnColorPrimary =  Color(0xff9d8899);
const Color kBtnColorInfo =  Color(0xff1e1d2b);
const Color kBtnColorSuccess =  Color(0xff62a263);
const Color kBtnColorWarning =  Color(0xffe09532);
const Color kBtnColorDanger =  Color(0xfff24334);