import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:how_far/showCalculationsSheet.dart';
import 'alerts.dart';
import 'constants.dart';
import 'fuel_data.dart';
import 'package:flutter/cupertino.dart';
import 'picker_dropdown.dart';
import 'basic_button.dart';
import 'record_index_generator.dart';
import 'display_fields.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

double fuelPrice = 00.00;
String platform =
(Platform.isIOS == true ? Platform.isIOS : Platform.isAndroid) as String;
double distance = 00.00;
double consumption = 00.00;
double? totalCost;



Widget buildBottomSheet(BuildContext context) => TotalResultsSheet();

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    locationCupertinoScrollController =
        FixedExtentScrollController(initialItem: kLocationListIndex);
    fuelTypeCupertinoScrollController =
        FixedExtentScrollController(initialItem: kFuelTypeListIndex);
    petrolCupertinoScrollController =
        FixedExtentScrollController(initialItem: kFuelGradeListIndex);
  }


  @override
  Widget build(BuildContext context) {
    if (selectedFuelType == 'petrol') {
      fuelPrice = petrolValue;
    } else if (selectedFuelType == 'diesel') {
      fuelPrice = dieselValue;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0),
        child: SafeArea(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                //backgroundColor: Colors.red,
                backgroundImage: AssetImage('assets/howfarLogo.png'),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Location'),
                                  //buildCupertinoPicker(),
                                  Visibility(
                                      visible: Platform.isIOS,
                                      child: basicElevatedBTN(
                                          btnText: 'Location',
                                          onPressed: () {
                                            showLocationActionSheet(context);
                                          })),
                                  Visibility(
                                    visible: Platform.isAndroid,
                                    child: buildAndroidLocationDropdown(
                                        updateValueAndUI: () {
                                          setState(() {
                                            selectedLocation;
                                          });
                                        }),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Fuel Type'),
                                  Visibility(
                                      visible: Platform.isIOS,
                                      child: basicElevatedBTN(
                                          btnText: 'Fuel Type',
                                          onPressed: () {
                                            showFuelTypeActionSheet(context);
                                          })),
                                  Visibility(
                                    visible: Platform.isAndroid,
                                    child: buildAndroidFuelTypeDropdown(
                                        updateValueAndUI: () {
                                          setState(() {
                                            //selectedFuelType;
                                          });
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Fuel Grade'),
                                  Visibility(
                                      visible: Platform.isIOS,
                                      child: basicElevatedBTN(
                                        btnText: 'Octane',
                                        onPressed: () {
                                          showPetrolTypeActionSheet(context);
                                        },
                                      )),
                                  Visibility(
                                      visible: Platform.isAndroid,
                                      child: buildAndroidFuelGradeDropdown(
                                          updateiOSValueAndUI: () {
                                            setState(() {
                                              selectedFuelGrade;
                                              print(
                                                  'supposed to upgrade $selectedFuelGrade');
                                            });
                                          }))
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Fuel Price'),
                                  Container(
                                    width: 200.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            buildMainDisplayText(
                                                enteredText: 'R '),
                                            buildMainDisplayText(
                                                enteredText:
                                                fuelPrice.toString()),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Distance (km)'),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      print('DISTANCE: $value');
                                      distance = double.parse(value);
                                    },
                                    decoration: InputDecoration(
                                      //labelText: distance.toString(),
                                      hintText: 'KM',
                                      border: OutlineInputBorder(),
                                    ),
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Consumption'),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      print('CONSUMPTION $value');
                                      consumption = double.parse(value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'L/KM',
                                      border: OutlineInputBorder(),
                                    ),
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: basicElevatedBTN(
                                  btnText: 'Calculate',
                                  onPressed: () {
                                    //iOS
                                    if (Platform.isIOS == true) {
                                      try {
                                        selectedFuelType;
                                        selectedFuelGrade;
                                        canGetFuelData = true;
                                      } catch (e) {
                                        print(
                                            'Please select a fuel type (iOS): $e');
                                        canGetFuelData = false;
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (context) => iOSErrorAlert(
                                                errorMessage:
                                                'Please select your fuel type info. \n i.e: Petrol, 95 Unleaded'));
                                      }
                                      if (selectedFuelType == 'petrol' &&
                                          canGetFuelData == true) {
                                        petrolRecordIndexGeneration();
                                        getPetrolData(
                                            recordIndex: selectedRecordIndex);
                                        //fuelPrice = petrolValue;

                                        Future<void> updateDetails() async {
                                          await Future.delayed(Duration(seconds: 1));

                                          setState(() {
                                            fuelPrice = petrolValue;
                                            totalCost = (distance / consumption) *
                                                fuelPrice;
                                            totalCost = double.parse(
                                                totalCost!.toStringAsFixed(2));
                                            print('###FINAL fuel price => $fuelPrice and $petrolValue');
                                          });

                                          showModalBottomSheet(
                                            context: context,
                                            builder: buildBottomSheet,
                                          );
                                        }
                                        updateDetails();

                                        //var totalCost = (distance/consumption)*fuelPrice;
                                      } else if (selectedFuelType == 'diesel') {
                                        dieselRecordIndexGeneration();
                                        getDieselData(
                                            recordIndex: selectedRecordIndex);

                                        Future<void> updateDetails() async {
                                          await Future.delayed(Duration(seconds: 1));
                                          setState(() {
                                            fuelPrice = dieselValue;
                                            totalCost = (distance / consumption) *
                                                fuelPrice;
                                            totalCost = double.parse(
                                                totalCost!.toStringAsFixed(2));
                                            print('###FINAL fuel price => $fuelPrice and 000000 $dieselValue 000000');
                                          });
                                          showModalBottomSheet(
                                            context: context,
                                            builder: buildBottomSheet,
                                          );
                                        }
                                        updateDetails();

                                      } else {
                                        print(
                                            'from_homeView => please select a fuel type (ios)');
                                      }
                                    }
                                    //android
                                    else {
                                      try {
                                        selectedFuelType;
                                        selectedFuelGrade;
                                        canGetFuelData = true;
                                      } catch (e) {
                                        print(
                                            'Please select a fuel type (Android): $e');
                                        canGetFuelData = false;
                                        showDialog(
                                            context: context,
                                            builder: (context) => AndroidErrorAlert(
                                                errorMessage:
                                                'Please select your fuel type info. \n i.e: Petrol, 95 Unleaded'));
                                      }
                                      if (selectedFuelType == 'petrol') {


                                        petrolRecordIndexGeneration();
                                        getPetrolData(
                                            recordIndex: selectedRecordIndex);
                                        //print('petrol record at selected index $selectedRecordIndex');
                                        //fuelPrice = petrolValue;

                                        Future<void> updateDetails() async {
                                          await Future.delayed(Duration(seconds: 1));
                                          setState(() {
                                            fuelPrice = petrolValue;
                                            totalCost = (distance / consumption) * fuelPrice;
                                            totalCost = double.parse(
                                                totalCost!.toStringAsFixed(2));
                                            print('###FINAL fuel price => $fuelPrice and $petrolValue');
                                          });
                                          showModalBottomSheet(
                                            context: context,
                                            builder: buildBottomSheet,
                                          );
                                        }
                                        updateDetails();


                                        //print('selected record index: $selectedRecordIndex');
                                      } else if (selectedFuelType == 'diesel') {
                                        dieselRecordIndexGeneration();
                                        getDieselData(
                                            recordIndex: selectedRecordIndex);

                                        Future<void> updateDetails() async {
                                          await Future.delayed(Duration(seconds: 1));
                                          setState(() {
                                            fuelPrice = dieselValue;
                                            totalCost = (distance / consumption) * fuelPrice;
                                            totalCost = double.parse(
                                                totalCost!.toStringAsFixed(2));
                                            print('###FINAL fuel price => $fuelPrice and 0000 $dieselValue 000000');
                                          });
                                          showModalBottomSheet(
                                            context: context,
                                            builder: buildBottomSheet,
                                          );
                                        }
                                        updateDetails();


                                      } else {
                                        print(
                                            'from_homeView => please select a fuel type (android)');
                                      }
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
