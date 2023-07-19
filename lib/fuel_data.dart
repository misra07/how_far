
import 'package:flutter/cupertino.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_view.dart';

late String petrolLocation;
late String petrolOctane;
late String petrolType;
late double petrolValue = 00;

void getPetrolData({required int recordIndex}) async {

  http.Response response = await http.get(kFSAUrl, headers: {'Key': kFSAkey});

  String fullResponse = response.body;
  //petrol = jsonDecode(fullResponse)['petrol'];
  petrolLocation = jsonDecode(fullResponse)['petrol'][recordIndex]['location'];
  petrolOctane = jsonDecode(fullResponse)['petrol'][recordIndex]['octane'];
  petrolType = jsonDecode(fullResponse)['petrol'][recordIndex]['type'];
  petrolValue = jsonDecode(fullResponse)['petrol'][recordIndex]['value']/100;

  print('from getPetrolData $petrolLocation, $petrolOctane $petrolType, $petrolValue');

}



// //var petrol = jsonDecode(fullResponse)[fuelType];
// location = jsonDecode(fullResponse)[fuelType][2]['location'];
// octane = jsonDecode(fullResponse)[fuelType][0]['octane'];
// type = jsonDecode(fullResponse)[fuelType][0]['type'];
// value = jsonDecode(fullResponse)[fuelType][0]['value'];
// dvalue = value/100;
//
// print('$location, $octane, $type, $dvalue');