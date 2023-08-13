import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:how_far/model/constants.dart';
import 'package:how_far/controller/showCalculationsSheet.dart';
import 'package:how_far/model/texts.dart';
import 'package:how_far/view/alerts.dart';
import '../model/fuel_data.dart';
import 'package:flutter/cupertino.dart';
import '../controller/picker_dropdown.dart';
import 'package:how_far/view/basic_button.dart';
import '../model/record_index_generator.dart';
import '../controller/display_fields.dart';
import '../view/home_view.dart';

//CURRENTLY UNUSED
class buildTotalButton extends StatefulWidget {
  const buildTotalButton(buildTotalButton context, {super.key});

  @override
  State<buildTotalButton> createState() => buildTotalButtonState();
}

class buildTotalButtonState extends State<buildTotalButton> {
  @override



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


  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
