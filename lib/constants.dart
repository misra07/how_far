
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final String kFSAkey = '181a1f7308714687b520b4a4fba216b7';
final  Uri kFSAUrl = Uri.parse('https://api.fuelsa.co.za/exapi/fuel/current');

List<Widget> kLocationList = [
  Center(child: Text('Reef')),
  Center(child: Text('Coast')),
];
int kLocationListIndex = 0;
int kFuelTypeListIndex = 0;
int kFuelGradeListIndex = 0;

List<Widget> kFuelTypeList = [
  Center(child: Text('diesel')),
  Center(child: Text('petrol')),
];
List<Widget> kPetrolList = [
  Center(child: Text('95 LRP'),),
  Center(child: Text('95 unleaded'),),
  Center(child: Text('93 unleaded'),),
];
List<Widget> kDieselList = [
  Center(child: Text('50 PPM'),),
  Center(child: Text('500 PPM'),),
];












