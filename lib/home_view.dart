import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:how_far/constants.dart';
import 'package:how_far/showCalculationsSheet.dart';
import 'package:how_far/texts.dart';
import 'alerts.dart';
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
String locationSelectorLabel = ((kLocationList[kLocationListIndex] as Center).child as Text).data?? 'Inland';
String fuelTypeSelectorLabel = ((kFuelTypeList[kFuelTypeListIndex] as Center).child as Text).data ?? 'petrol';
String defaultFuelGradeSelectorLabel = ((kPetrolList[kFuelGradeListIndex] as Center).child as Text).data ?? ((kDieselList[kFuelGradeListIndex] as Center).child as Text).data!;
String initialFuelGrade = '';

void updateFields(){
  if (selectedRecordIndex == 999){
    selectedRecordIndex = 4;
  }
}


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

    // setState(() {
    //   selectedRecordIndex;
    //   locationSelectorLabel;
    // });
  }



  @override
  Widget build(BuildContext context) {
    if (selectedFuelType == 'petrol') {
      fuelPrice = petrolValue;
    } else if (selectedFuelType == 'diesel') {
      fuelPrice = dieselValue;
    }


    return Scaffold(
      backgroundColor: kColorLightShade,
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
                                  basicText(text: 'Location', color: kColorDarkShade,),
                                  Visibility(
                                      visible: Platform.isIOS,
                                      child: infoElevatedBTN(
                                          btnText: locationSelectorLabel,
                                          onPressed: () {
                                            showLocationActionSheet(context);

                                            setState(() {
                                              locationSelectorLabel = ((kLocationList[kLocationListIndex] as Center).child as Text).data!;
                                              print('Xxxxxxxx');
                                            });
                                          },


                                      )),
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
                                  basicText(text: 'Fuel Type', color: kColorDarkShade,),
                                  Visibility(
                                      visible: Platform.isIOS,
                                      child: infoElevatedBTN(
                                          btnText: fuelTypeSelectorLabel,
                                          onPressed: () {

                                            showFuelTypeActionSheet(context);
                                            setState(() {
                                              locationSelectorLabel = ((kLocationList[kLocationListIndex] as Center).child as Text).data!;
                                              fuelTypeSelectorLabel = ((kFuelTypeList[kFuelTypeListIndex] as Center).child as Text).data!;

                                            });
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
                                  basicText(text: 'Fuel Grade', color: kColorDarkShade,),
                                  Visibility(
                                      visible: Platform.isIOS,
                                      child: infoElevatedBTN(
                                        btnText: defaultFuelGradeSelectorLabel,
                                        onPressed: () {
                                          showFuelGradeActionSheet(context);
                                          print('xOXOO  $selectedFuelType');
                                          print('shhhshhshshshsh ${((kFuelTypeList[kFuelTypeListIndex] as Center).child as Text).data }');
                                          setState(() {

                                            fuelTypeSelectorLabel = ((kFuelTypeList[kFuelTypeListIndex] as Center).child as Text).data!;
                                            //print('$selectedRecordIndex');

                                          });
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
                                  basicText(text: 'Fuel Price', color: kColorDarkShade,),
                                  Container(
                                    width: 200.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: kBtnColorDefault,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Container(
                                      color: kColorLightAccent,
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
                                    ),
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
                                  basicText(text: 'Distance', color: kColorDarkShade,),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      try {
                                        distance = double.parse(value);
                                      } catch(e){
                                        distance = 0.00;
                                      }
                                      setState(() {
                                        defaultFuelGradeSelectorLabel = selectedFuelGrade;
                                        //defaultFuelGradeSelectorLabel = ((kPetrolList[kFuelGradeListIndex] as Center).child as Text).data ?? ((kDieselList[kFuelGradeListIndex] as Center).child as Text).data!;
                                        print('DISTANCE!!!! $defaultFuelGradeSelectorLabel');
                                      });
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
                                  basicText(text: 'Consumption', color: kColorDarkShade,),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      try{
                                        consumption = double.parse(value);
                                      } catch (e){
                                        consumption = 0.00;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'L/100km',
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
                              child: primaryElevatedBTN(
                                  btnText: 'Calculate',
                                  onPressed: () async {

                                    selectedRecordIndex == 999 ? selectedRecordIndex = 4: selectedRecordIndex =4;





                                    if (Platform.isIOS == true) {


                                    //iOS
                                      if (selectedFuelType == 'petrol') {
                                        petrolRecordIndexGeneration();
                                        getPetrolData(recordIndex: selectedRecordIndex);


                                        Future<void> updateDetails() async {
                                          await Future.delayed(Duration(seconds: 1));
                                          setState(() {
                                            fuelPrice = dieselValue;
                                            totalCost = (distance / consumption) *
                                                fuelPrice;
                                            totalCost = double.parse(
                                                totalCost!.toStringAsFixed(2));
                                            print('###FINAL fuel price => $fuelPrice and 000000 $petrolValue 000000');
                                          });
                                          showModalBottomSheet(
                                            context: context,
                                            builder: buildBottomSheet,
                                          );
                                        }
                                        updateDetails();
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
                                        print('from_homeView => please select a fuel type (ios) $selectedFuelType the price is $fuelPrice');
                                      }
                                    }
                                    //android
                                    else {
                                      try {
                                        selectedFuelType;
                                        selectedFuelGrade;
                                        canCalculateCost = true;
                                      } catch (e) {
                                        print(
                                            'Please select a fuel type (Android): $e');
                                        canCalculateCost = false;
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

