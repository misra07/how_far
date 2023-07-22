import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'constants.dart';
import 'fuel_data.dart';
import 'package:flutter/cupertino.dart';
import 'picker_dropdown.dart';
import 'basic_button.dart';
import 'record_index_generator.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}
double fuelPrice = 00.00;
String platform = (Platform.isIOS == true ? Platform.isIOS: Platform.isAndroid) as String;


class _HomeViewState extends State<HomeView> {
 @override
  void initState() {
    super.initState();
    locationCupertinoScrollController = FixedExtentScrollController(initialItem: kLocationListIndex);
    fuelTypeCupertinoScrollController = FixedExtentScrollController(initialItem: kFuelTypeListIndex);
    petrolCupertinoScrollController = FixedExtentScrollController(initialItem: kFuelGradeListIndex);

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
              Container(
                width: 80.0,
                height: 80.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Location'),
                              //buildCupertinoPicker(),
                              Visibility(
                                  visible: Platform.isIOS,
                                  child: basicElevatedBTN(btnText: 'Location',
                                      onPressed: (){
                                        showLocationActionSheet(context);
                                      }
                                  )
                              ),
                              Visibility(
                                visible: Platform.isAndroid,
                                  child: buildAndroidLocationDropdown(
                                      updateValueAndUI: (){
                                        setState(() {
                                          selectedLocation;
                                        });
                                      }
                                  ),
                              )
                            ],
                          ),),
                          SizedBox(width: 20.0,),
                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Fuel Type'),
                              Visibility(
                                  visible: Platform.isIOS,
                                  child: basicElevatedBTN(btnText: 'Fuel Type', onPressed: (){
                                    showFuelTypeActionSheet(context);
                                  })
                              ),
                              Visibility(
                                visible: Platform.isAndroid,
                                child: buildAndroidFuelTypeDropdown(
                                    updateValueAndUI: (){
                                      setState(() {
                                        //selectedFuelType;
                                      });
                                    }
                                ),
                              )
                            ],
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Fuel Grade'),
                              Visibility(
                                  visible:Platform.isIOS,
                                  child: basicElevatedBTN(btnText: 'Octane', onPressed: (){
                                    showPetrolTypeActionSheet(context);},
                                  )
                              ),
                              Visibility(
                                visible: Platform.isAndroid,
                                  child: buildAndroidFuelGradeDropdown(
                                      updateiOSValueAndUI: (){
                                        setState(() {
                                          selectedFuelGrade;
                                          print('supposed to upgrade $selectedFuelGrade');
                                        });
                                      }
                                  )
                              )
                            ],
                          ),),
                          SizedBox(width: 20.0,),
                          Expanded(child: Column(
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
                                child:Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('R ',
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.black54,
                                          )
                                      ),
                                      Text(fuelPrice.toString(),
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.black54,
                                          )
                                      ),
                                    ],
                                  )
                                ),
                              )
                            ],
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Consumption'),
                              TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  print('changed');
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter some text',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),),
                          SizedBox(width: 20.0,),
                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Distance'),
                              TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  print('changed');
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter some text',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: basicElevatedBTN(
                                btnText: 'Calculate',
                                onPressed: (){
                                  //iOS
                                  if(Platform.isIOS == true){
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
                                        Future.delayed(Duration(seconds: 2), () {
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
                                  //android
                                  else {
                                    print('testing Android');
                                    if(selectedFuelType == 'petrol'){
                                      petrolRecordIndexGeneration();
                                      getPetrolData(recordIndex: selectedRecordIndex);
                                      //print('petrol record at selected index $selectedRecordIndex');

                                      Future.delayed(Duration(seconds: 2), () {
                                        setState(() {
                                          fuelPrice = petrolValue;
                                        });
                                      });
                                      //print('selected record index: $selectedRecordIndex');
                                    } else if (selectedFuelType == 'diesel'){
                                      dieselRecordIndexGeneration();
                                      getDieselData(recordIndex: selectedRecordIndex);
                                      Future.delayed(Duration(seconds: 2), () {
                                        setState(() {
                                          fuelPrice = petrolValue;
                                        });
                                      });
                                      //print('selected record index: $selectedRecordIndex');
                                    } else {
                                      print('from_homeView => please select a fuel type (android)');
                                    }


                                  }

                            })
                            ,),
                        ],
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}





