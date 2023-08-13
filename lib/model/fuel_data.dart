import 'constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../view/home_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io' show Platform;

late String petrolLocation;
late String petrolOctane ;
late String petrolType;
double petrolValue = 00;
bool canCalculateCost = true;
http.Response response = http.Response('{"message": "Hello, world!"}', 999);
bool canGetFuelData = false;
bool hasInternet = true;
String connectionErrorCause = 'NA';

// connectionErrorCause cases
// 'none': no internet
// 'wifi': wifi has no internet
// 'NA': no connection errors
//'other': something went wong. i.e api call did not return 200

Future networkCheck() async{
  final connectivityResult = await (Connectivity().checkConnectivity());


  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
    hasInternet = true;
    connectionErrorCause = 'NA';
    print('connection is mobile');
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
    hasInternet = true;
    connectionErrorCause = 'NA';
    print('connection is wifi');
  } else if (connectivityResult == ConnectivityResult.other) {
    // I am connected to a ethernet network.
    hasInternet = true;
    connectionErrorCause = 'NA';
    print('connection is other');
  } else if (connectivityResult == ConnectivityResult.none) {
    // I am not connected to any network.
    hasInternet = false;
    connectionErrorCause = 'none';
    print('connection is none');
  }
}

void getPetrolData({required int recordIndex}) async {

    try{
      response = await http.get(kFSAUrl, headers: {'Key': kFSAkey});
      connectionErrorCause = 'NA';
      canGetFuelData = true;
    } catch (e){
      //connected to wifi but no internet
      connectionErrorCause = 'wifi';
      canGetFuelData = false;

    }

    if (response.statusCode == 200){
      String fullResponse = response.body;
      petrolLocation = jsonDecode(fullResponse)['petrol'][recordIndex]['location'];
      petrolOctane = jsonDecode(fullResponse)['petrol'][recordIndex]['octane'];
      petrolType = jsonDecode(fullResponse)['petrol'][recordIndex]['type'];
      petrolValue = jsonDecode(fullResponse)['petrol'][recordIndex]['value']/100;
    } else {
      print('unable to get fuel data');
      //canGetFuelData = false; handle different api status responses here

    }
}


late String dieselLocation;
late String dieselPPM;
double dieselValue = 00;

void getDieselData({required int recordIndex}) async {

  try {
    response = await http.get(kFSAUrl, headers: {'key': kFSAkey});
    connectionErrorCause = 'NA';
    canGetFuelData = true;
  } catch (e) {
    //connected to wifi but no internet
    connectionErrorCause = 'wifi';
    canGetFuelData = false;
  }
  if(response.statusCode == 200){
    String fullResponse = response.body;
    dieselLocation = jsonDecode(fullResponse)['diesel'][recordIndex]['location'];
    dieselPPM = jsonDecode(fullResponse)['diesel'][recordIndex]['percentage'];
    dieselValue = jsonDecode(fullResponse)['diesel'][recordIndex]['value']/100;
  } else {
    print('unable to get fuel data');
  }

}


