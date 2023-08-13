import 'constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../view/home_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

late String petrolLocation;
late String petrolOctane ;
late String petrolType;
double petrolValue = 00;
bool canCalculateCost = true;
late http.Response response;
bool canGetFuelData = false;




void networkCheck() async{
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
    print('connection is mobile');
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
    print('connection is wifi');
  } else if (connectivityResult == ConnectivityResult.other) {
    // I am connected to a ethernet network.
    print('connection is other');
  } else if (connectivityResult == ConnectivityResult.none) {
    // I am not connected to any network.
    print('connection is none');
  }
}




void getPetrolData({required int recordIndex}) async {

  networkCheck();
  response = await http.get(kFSAUrl, headers: {'Key': kFSAkey});

  if (response.statusCode == 200){
    String fullResponse = response.body;
    petrolLocation = jsonDecode(fullResponse)['petrol'][recordIndex]['location'];
    petrolOctane = jsonDecode(fullResponse)['petrol'][recordIndex]['octane'];
    petrolType = jsonDecode(fullResponse)['petrol'][recordIndex]['type'];
    petrolValue = jsonDecode(fullResponse)['petrol'][recordIndex]['value']/100;
    //canCalculateCost = true;
    //print(' the record is $recordIndex');
    //print(response.body);

    //print('from getPetrolData $petrolLocation, $petrolOctane $petrolType, $petrolValue');
    //print('####### $petrolValue');
  } else if(response.statusCode != 200) {
    print('something went wrong');
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


