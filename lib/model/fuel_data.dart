import 'constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

late String petrolLocation;
late String petrolOctane ;
late String petrolType;
double petrolValue = 00;
bool canCalculateCost = true;
http.Response response = http.Response('{"message": "Hello, world!"}', 999);
bool canGetFuelData = true;
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
    // Connected to a mobile network.
    hasInternet = true;
    connectionErrorCause = 'NA';

  } else if (connectivityResult == ConnectivityResult.wifi) {
    // Connected to a wifi network.
    hasInternet = true;
    connectionErrorCause = 'NA';
  } else if (connectivityResult == ConnectivityResult.other) {
    // Connected to a ethernet network.
    hasInternet = true;
    connectionErrorCause = 'NA';
  } else if (connectivityResult == ConnectivityResult.none) {
    //Not connected to any network.
    hasInternet = false;
    connectionErrorCause = 'none';
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
  }
}



