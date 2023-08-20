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
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

double fuelPrice = 00.00;
String platform =
(Platform.isIOS? Platform.isIOS : Platform.isAndroid) as String;
double distance = 00.00;
double consumption = 00.00;
double? totalCost;
String formattedTotalCost = NumberFormat('#,##0.00', 'en_US').format(totalCost);
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
      //backgroundColor: kColorLightShade,
      //backgroundColor: const Color(0xff252E42),
      body: Container(
        decoration: const BoxDecoration (
          image: DecorationImage(image: AssetImage('assets/flatGeoBG.jpg'), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Container(

              decoration: BoxDecoration (
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: const Color(0xff05172e).withOpacity(0.9)
              ),
            ),

            Padding(
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
                                        const BasicText(text: 'Location', color: kColorWhiteFancy,),
                                        const SizedBox(height: 10.0,),
                                        Visibility(
                                          visible: Platform.isIOS,
                                          child: DefaultElevatedBTN(
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
                                        const BasicText(text: 'Fuel Type', color: kColorWhiteFancy,),
                                        const SizedBox(height: 10.0,),
                                        Visibility(
                                            visible: Platform.isIOS,
                                            child: DefaultElevatedBTN(
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
                                        const BasicText(text: 'Fuel Grade', color: kColorWhiteFancy,),
                                        const SizedBox(height: 10.0,),
                                        Visibility(
                                            visible: Platform.isIOS,
                                            child: DefaultElevatedBTN(
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
                                        const BasicText(text: 'Fuel Price', color: kColorWhiteFancy,),
                                        const SizedBox(height: 10.0,),
                                        Container(
                                          width: 200.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xff3C4B68),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Container(
                                            color: const Color(0xff20293B),
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
                                        const BasicText(text: 'Distance', color: kColorWhiteFancy,),
                                        const SizedBox(height: 10.0,),
                                        Container(
                                          height: 50.0,
                                          decoration: const BoxDecoration (
                                            //border: Border.all(color: Color(0xff20293B), width: 3.0)
                                          ),
                                          child: TextField(
                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                            onChanged: (value) {
                                              try {
                                                value = value.replaceAll(',', '.');
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
                                              hintText: 'km',
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Color(0xff20293B),
                                            ),
                                            style: const TextStyle(
                                              fontSize: 25.0,
                                              color: kColorWhiteFancy,

                                            ),
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
                                        const BasicText(text: 'Consumption', color: kColorWhiteFancy,),
                                        const SizedBox(height: 10.0,),
                                        Container(
                                          height: 50.0,
                                          child: TextField(
                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                            onChanged: (value) {
                                              try{
                                                value = value.replaceAll(',', '.');
                                                consumption = double.parse(value);
                                              } catch (e){
                                                consumption = 0.00;
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'l/100km',
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Color(0xff20293B),
                                            ),
                                            style: const TextStyle(
                                              fontSize: 25.0,
                                              color: kColorWhiteFancy,
                                            ),
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
          ],
        )
      ),
    );
  }

  PrimaryElevatedBTN buildTotalButton(BuildContext context) {
    return PrimaryElevatedBTN(
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
            //only diesel selected'
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
                        return const IosErrorAlert(errorMessage: 'Something went wrong. Please try again later');
                      }
                  );
                } else {
                  switch (connectionErrorCause){
                    case 'wifi':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const IosErrorAlert(errorMessage: 'No internet connection. \nWifi has no internet access');
                          }
                      );
                      break;
                    case 'none':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const IosErrorAlert(errorMessage: 'No internet connection');
                          }
                      );
                      break;
                    case 'other':
                      showDialog
                        (context: context,
                          builder: (BuildContext context){
                            return const IosErrorAlert(errorMessage: 'Something went wrong. Please try again later');
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

                  if (canCalculateCost) {
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
                        return const IosErrorAlert(errorMessage: 'Something went wrong. Please try again later');
                      }
                  );
                } else {
                  switch (connectionErrorCause){
                    case 'wifi':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const IosErrorAlert(errorMessage: 'No internet connection. \nWifi has no internet access');
                          }
                      );
                      break;
                    case 'none':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const IosErrorAlert(errorMessage: 'No internet connection');
                          }
                      );
                      break;
                    case 'other':
                      showDialog
                        (context: context,
                          builder: (BuildContext context){
                            return const IosErrorAlert(errorMessage: 'Something went wrong. Please try again later');
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

                  if (canCalculateCost){

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
                        return const AndroidErrorAlert(errorMessage: 'Something went wrong. Please try again later');
                      }
                  );
                } else {
                  switch (connectionErrorCause){
                    case 'wifi':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AndroidErrorAlert(errorMessage: 'No internet connection. \nWifi has no internet access');
                          }
                      );
                      break;
                    case 'none':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AndroidErrorAlert(errorMessage: 'No internet connection');
                          }
                      );
                      break;
                    case 'other':
                      showDialog
                        (context: context,
                          builder: (BuildContext context){
                            return const AndroidErrorAlert(errorMessage: 'Something went wrong. Please try again later');
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

                  if (canCalculateCost){

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
                        return const AndroidErrorAlert(errorMessage: 'Something went wrong. Please try again later');
                      }
                  );
                } else {
                  switch (connectionErrorCause){
                    case 'wifi':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AndroidErrorAlert(errorMessage: 'No internet connection. \nWifi has no internet access');
                          }
                      );
                      break;
                    case 'none':
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AndroidErrorAlert(errorMessage: 'No internet connection');
                          }
                      );
                      break;
                    case 'other':
                      showDialog
                        (context: context,
                          builder: (BuildContext context){
                            return const AndroidErrorAlert(errorMessage: 'Something went wrong. Please try again later');
                          }
                      );
                  }
                }
              }
              updateDetails();
            }
          }
        });
  }
}

