import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:how_far/view/alerts.dart';
import '../model/fuel_data.dart';
import '../controller/picker_dropdown.dart';
import 'package:how_far/view/basic_button.dart';
import '../model/record_index_generator.dart';
import '../view/home_view.dart';

//CURRENTLY UNUSED
class BuildTotalButton extends StatefulWidget {
  const BuildTotalButton(BuildTotalButton context, {super.key});

  @override
  State<BuildTotalButton> createState() => BuildTotalButtonState();
}

class BuildTotalButtonState extends State<BuildTotalButton> {
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
            //only diesel selected
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


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
