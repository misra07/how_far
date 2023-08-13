import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:how_far/model/constants.dart';
import 'package:how_far/controller/showCalculationsSheet.dart';
import 'package:how_far/model/texts.dart';
import 'alerts.dart';
import '../model/fuel_data.dart';
import '../controller/picker_dropdown.dart';
import 'basic_button.dart';
import '../model/record_index_generator.dart';
import '../controller/display_fields.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

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


Widget buildBottomSheet(BuildContext context) => const TotalResultsSheet();

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
      backgroundColor: kColorLightShade,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0),
        child: SafeArea(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50.0,
                //backgroundColor: Colors.red,
                backgroundImage: AssetImage('assets/howfarLogo.png'),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
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
                                        });
                                      },
                                    ),
                                  ),
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
                            const SizedBox(
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
                                            });
                                          }))
                                ],
                              ),
                            ),
                            const SizedBox(
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
                                          padding: const EdgeInsets.symmetric(
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

                                      });
                                    },
                                    decoration: const InputDecoration(
                                      //labelText: distance.toString(),
                                      hintText: 'KM',
                                      border: OutlineInputBorder(),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
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
                                    decoration: const InputDecoration(
                                      hintText: 'L/100km',
                                      border: OutlineInputBorder(),
                                    ),
                                    style: const TextStyle(
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
                              child: buildTotalButton(context),
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

  primaryElevatedBTN buildTotalButton(BuildContext context) {
    return primaryElevatedBTN(
        btnText: 'Calculate',
        onPressed: () async {

          selectedRecordIndex == 999 ? selectedRecordIndex = 4: selectedRecordIndex =4;
          defaultFuelGradeSelectorLabel = selectedFuelGrade;


          if(selectedFuelType == 'petrol' && selectedFuelGrade == 'none') {
            selectedFuelGrade = '95 unleaded';
            canCalculateCost = false;
          } else if (selectedFuelType == 'diesel' && selectedFuelGrade == 'none') {
            selectedFuelGrade = '50 PPM';
            canCalculateCost = false;
            print('only diesel selected');
          } else {
            canCalculateCost = true;
          }


          if (Platform.isIOS) {

            //iOS
            if (selectedFuelType == 'petrol') {

              petrolRecordIndexGeneration();
              getPetrolData(recordIndex: selectedRecordIndex);

              Future<void> updateDetails() async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  fuelPrice = petrolValue;

                  if (canCalculateCost){

                    totalCost = (distance / consumption) * fuelPrice;
                    totalCost = double.parse(
                        totalCost!.toStringAsFixed(2));
                  } else {
                    totalCost = 0.00;
                  }

                });
                if(canGetFuelData) {
                  //api call is successful
                  showModalBottomSheet(
                    context: context,
                    builder: buildBottomSheet,
                  );






                } else if (!canGetFuelData && connectionErrorCause == 'NA'){
                  //api call unsuccessful
                  showDialog
                    (context: context,
                      builder: (BuildContext context){
                        return IosErrorAlert(errorMessage: 'Something went wrong. Plese try again later');
                      }
                  );
                } else {
                  switch (connectionErrorCause){
                    case 'wifi':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return IosErrorAlert(errorMessage: 'No internet connection. \nWifi has no internet access');
                          }
                      );
                      break;
                    case 'none':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return IosErrorAlert(errorMessage: 'No internet connection');
                          }
                      );
                      break;
                    case 'other':
                      showDialog
                        (context: context,
                          builder: (BuildContext context){
                            return IosErrorAlert(errorMessage: 'Something went wrong. Plese try again later');
                          }
                      );
                  }
                }

              }
              updateDetails();
            } else if (selectedFuelType == 'diesel') {
              dieselRecordIndexGeneration();
              getDieselData(
                  recordIndex: selectedRecordIndex);

              Future<void> updateDetails() async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  fuelPrice = dieselValue;

                  if (canCalculateCost == true) {
                    totalCost = (distance / consumption) * fuelPrice;
                    totalCost = double.parse(totalCost!.toStringAsFixed(2));
                  } else {
                    totalCost = 0.00;
                  }


                });

                if(canGetFuelData) {
                  //api call is successful
                  showModalBottomSheet(
                    context: context,
                    builder: buildBottomSheet,
                  );
                } else if (!canGetFuelData && connectionErrorCause == 'NA'){
                  //api call unsuccessful
                  showDialog
                    (context: context,
                      builder: (BuildContext context){
                        return IosErrorAlert(errorMessage: 'Something went wrong. Plese try again later');
                      }
                  );
                } else {
                  switch (connectionErrorCause){
                    case 'wifi':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return IosErrorAlert(errorMessage: 'No internet connection. \nWifi has no internet access');
                          }
                      );
                      break;
                    case 'none':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return IosErrorAlert(errorMessage: 'No internet connection');
                          }
                      );
                      break;
                    case 'other':
                      showDialog
                        (context: context,
                          builder: (BuildContext context){
                            return IosErrorAlert(errorMessage: 'Something went wrong. Plese try again later');
                          }
                      );
                  }
                }
              }
              updateDetails();

            } else {
              //print('from_homeView => please select a fuel type (ios) $selectedFuelType the price is $fuelPrice');
            }
          }
          //android
          else {
            if (selectedFuelType == 'petrol') {

              petrolRecordIndexGeneration();
              getPetrolData(
                  recordIndex: selectedRecordIndex);
              //print('petrol record at selected index $selectedRecordIndex');
              //fuelPrice = petrolValue;

              Future<void> updateDetails() async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  fuelPrice = petrolValue;

                  if (canCalculateCost == true){

                    totalCost = (distance / consumption) * fuelPrice;
                    totalCost = double.parse(totalCost!.toStringAsFixed(2));

                  } else {
                    totalCost = 0.00;
                  }

                });

                if(canGetFuelData) {
                  //api call is successful
                  showModalBottomSheet(
                    context: context,
                    builder: buildBottomSheet,
                  );
                } else if (!canGetFuelData && connectionErrorCause == 'NA'){
                  //api call unsuccessful
                  showDialog
                    (context: context,
                      builder: (BuildContext context){
                        return AndroidErrorAlert(errorMessage: 'Something went wrong. Plese try again later');
                      }
                  );
                } else {
                  switch (connectionErrorCause){
                    case 'wifi':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AndroidErrorAlert(errorMessage: 'No internet connection. \nWifi has no internet access');
                          }
                      );
                      break;
                    case 'none':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AndroidErrorAlert(errorMessage: 'No internet connection');
                          }
                      );
                      break;
                    case 'other':
                      showDialog
                        (context: context,
                          builder: (BuildContext context){
                            return AndroidErrorAlert(errorMessage: 'Something went wrong. Plese try again later');
                          }
                      );
                  }
                }

              }
              updateDetails();


              //print('selected record index: $selectedRecordIndex');
            } else if (selectedFuelType == 'diesel') {
              dieselRecordIndexGeneration();
              getDieselData(
                  recordIndex: selectedRecordIndex);

              Future<void> updateDetails() async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  fuelPrice = dieselValue;

                  if (canCalculateCost == true){

                    totalCost = (distance / consumption) * fuelPrice;
                    totalCost = double.parse(totalCost!.toStringAsFixed(2));

                  } else {
                    totalCost = 0.00;
                  }

                });

                if(canGetFuelData) {
                  //api call is successful
                  showModalBottomSheet(
                    context: context,
                    builder: buildBottomSheet,
                  );
                } else if (!canGetFuelData && connectionErrorCause == 'NA'){
                  //api call unsuccessful
                  showDialog
                    (context: context,
                      builder: (BuildContext context){
                        return AndroidErrorAlert(errorMessage: 'Something went wrong. Plese try again later');
                      }
                  );
                } else {
                  switch (connectionErrorCause){
                    case 'wifi':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AndroidErrorAlert(errorMessage: 'No internet connection. \nWifi has no internet access');
                          }
                      );
                      break;
                    case 'none':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AndroidErrorAlert(errorMessage: 'No internet connection');
                          }
                      );
                      break;
                    case 'other':
                      showDialog
                        (context: context,
                          builder: (BuildContext context){
                            return AndroidErrorAlert(errorMessage: 'Something went wrong. Plese try again later');
                          }
                      );
                  }
                }
              }
              updateDetails();


            } else {
              print(
                  'from_homeView => please select a fuel type (android)');
            }
          }
        });
  }
}

