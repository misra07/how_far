import 'dart:io';
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

    fuelPrice = selectedFuelType == 'petrol'? petrolValue: dieselValue;
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
                              //buildCupertinoPicker()
                              basicElevatedBTN(btnText: 'Location',
                                  onPressed: (){
                                    showLocationActionSheet(context);
                                  }
                              )
                            ],
                          ),),
                          SizedBox(width: 20.0,),
                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Fuel Type'),
                              basicElevatedBTN(btnText: 'Fuel Type', onPressed: (){
                              showFuelTypeActionSheet(context);
                              })
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
                              basicElevatedBTN(btnText: 'Octane', onPressed: (){
                                showPetrolTypeActionSheet(context);
                              })
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
                                child:Center(
                                  child: Text(fuelPrice.toString(),
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.black54,
                                      )
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
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
                              if (selectedFuelType == 'petrol'){
                                petrolRecordIndexGeneration();
                                getPetrolData(recordIndex: selectedRecordIndex);
                                void updateLabelLater() {
                                  Future.delayed(Duration(seconds: 2), () {
                                    setState(() {
                                      //fuelPrice = petrolValue;
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
                                print('from_homeView => please select a fuel type');
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



