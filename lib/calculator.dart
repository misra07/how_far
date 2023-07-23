

import 'package:flutter/material.dart';
import 'package:how_far/picker_dropdown.dart';
import 'package:how_far/record_index_generator.dart';
import 'fuel_data.dart';
import 'home_view.dart';
import 'dart:io' show Platform;

//CURRENTLY NOT IN USE
class RunCalculations extends StatefulWidget {
  @override
  State<RunCalculations> createState() => _RunCalculationsState();
}

class _RunCalculationsState extends State<RunCalculations> {
  void iOSCalculate(){
    if(Platform.isIOS == false){
      if (selectedFuelType == 'petrol'){
        petrolRecordIndexGeneration();
        getPetrolData(recordIndex: selectedRecordIndex);
        void updateLabelLater() {
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              fuelPrice = petrolValue;
            });
          });
        }
        updateLabelLater();
      } else if (selectedFuelType == 'diesel'){
        dieselRecordIndexGeneration();
        getDieselData(recordIndex: selectedRecordIndex);
        void updateLabelLater() {
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              fuelPrice = dieselValue;
            });
          });
        }
        updateLabelLater();
      } else {
        print('from_homeView => please select a fuel type (ios)');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    iOSCalculate();
    return Scaffold();
  }
}
