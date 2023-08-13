

import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_far/view/alerts.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../view/home_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io' show Platform;
import 'package:cupertino_icons/cupertino_icons.dart';

late String petrolLocation;
late String petrolOctane ;
late String petrolType;
double petrolValue = 00;
bool canCalculateCost = true;
late http.Response response;
bool canGetFuelData = false;
bool hasInternet = true;




Future networkCheck() async{
  final connectivityResult = await (Connectivity().checkConnectivity());

  // try{
  //   final connectivityResult = await (Connectivity().checkConnectivity());
  // } catch (e) {
  //   print('try error is : $e');
  // }

  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
    hasInternet = true;
    print('connection is mobile');
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
    hasInternet = true;
    print('connection is wifi');
  } else if (connectivityResult == ConnectivityResult.other) {
    // I am connected to a ethernet network.
    hasInternet = true;
    print('connection is other');
  } else if (connectivityResult == ConnectivityResult.none) {
    // I am not connected to any network.
    hasInternet = false;
    print('connection is none');
  }
}



void getPetrolData({required int recordIndex}) async {



    try{
      print('attempting to get fuel data');
      response = await http.get(kFSAUrl, headers: {'Key': kFSAkey});

    } catch (e){
      print('connected to wifi but no internet');
      canGetFuelData = false;
      if(Platform.isIOS){
        print('show iOS error alert');

        showDialog(
            context: context as BuildContext,
            builder: (BuildContext context) {
              return IosErrorAlert(errorMessage: 'No internet connection /n. If you are on wifi, insure your wifi has internet connectivity and try again');
            }
        );



        // showDialog(
        //     context: context as ,
        //     builder: (BuildContext context) {
        //       return CupertinoAlertDialog(
        //         title: Text('Test'),
        //         content: Text('this is a test'),
        //         actions: [
        //           CupertinoDialogAction(
        //               child: Text('close'),
        //             onPressed: (){
        //                 Navigator.of(context).pop();
        //             },
        //           )
        //         ],
        //       );
        //     }
        // );

      } else {
        print('show android error alert');

        // showDialog(
        //     context: context as BuildContext,
        //     builder: (BuildContext context) {
        //       return AndroidErrorAlert(errorMessage: 'No internet connection /n. If you are on wifi, insure your wifi has internet connectivity and try again');
        //     }
        // );

      }

    }


    if (response.statusCode == 200){
      String fullResponse = response.body;
      petrolLocation = jsonDecode(fullResponse)['petrol'][recordIndex]['location'];
      petrolOctane = jsonDecode(fullResponse)['petrol'][recordIndex]['octane'];
      petrolType = jsonDecode(fullResponse)['petrol'][recordIndex]['type'];
      petrolValue = jsonDecode(fullResponse)['petrol'][recordIndex]['value']/100;


    } else {
      print('unable to get fuel data');
      //canGetFuelData = false;

    }




}


late String dieselLocation;
late String dieselPPM;
double dieselValue = 00;

void getDieselData({required int recordIndex}) async {
  http.Response response = await http.get(kFSAUrl, headers: {'key': kFSAkey});

  String fullResponse = response.body;
  dieselLocation = jsonDecode(fullResponse)['diesel'][recordIndex]['location'];
  dieselPPM = jsonDecode(fullResponse)['diesel'][recordIndex]['percentage'];
  dieselValue = jsonDecode(fullResponse)['diesel'][recordIndex]['value']/100;

  //print('from getDieselData diesel location: $dieselLocation, diesel percentage: $dieselPPM, diesel value: $dieselValue');
}


