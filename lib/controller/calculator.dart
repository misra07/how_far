

import 'package:flutter/material.dart';
import 'package:how_far/controller/picker_dropdown.dart';
import 'package:how_far/model/record_index_generator.dart';
import '../model/fuel_data.dart';
import '../view/home_view.dart';
import 'dart:io' show Platform;

//CURRENTLY NOT IN USE
class RunCalculations extends StatefulWidget {
  const RunCalculations({super.key});

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
          Future.delayed(const Duration(seconds: 2), () {
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
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              fuelPrice = dieselValue;
            });
          });
        }
        updateLabelLater();
      } else {
        //print('from_homeView => please select a fuel type (ios)');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    iOSCalculate();
    return const Scaffold();
  }
}
