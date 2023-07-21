import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_far/fuel_data.dart';
import 'constants.dart';

late String selectedLocation = 'Reef';
String selectedFuelType = '';
late String selectedFuelGrade;

//iOS button pickers
var locationCupertinoScrollController = FixedExtentScrollController(initialItem: kLocationListIndex);
var fuelTypeCupertinoScrollController = FixedExtentScrollController(initialItem: kFuelTypeListIndex);
var petrolCupertinoScrollController = FixedExtentScrollController(initialItem: kFuelGradeListIndex);


//location ios picker
Future<void> showLocationActionSheet(BuildContext context) async {
  await showCupertinoModalPopup(
    context: context,
    builder: (context)=>CupertinoActionSheet(
      actions: [
        SizedBox(
          height: 150.0,
          child: buildLocationCupertinoPicker(),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'),
        onPressed: ()=>Navigator.pop(context),
      ),
    ),
  );
  //print('final selected location index is $kLocationListIndex');
  kLocationListIndex;
  if (kLocationListIndex == 0){
    selectedLocation = 'Reef';
  } else {
    selectedLocation = 'Coast';
  }
  //print(kLocationListIndex);
}
CupertinoPicker buildLocationCupertinoPicker() {
  return CupertinoPicker(
    scrollController: locationCupertinoScrollController,
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: Colors.lightBlueAccent.withOpacity(0.3),
    ),
    itemExtent: 50,
    onSelectedItemChanged: (selectedIndex){
      kLocationListIndex = selectedIndex;
      locationCupertinoScrollController.dispose();
      locationCupertinoScrollController = FixedExtentScrollController(initialItem: kLocationListIndex);
    }, children: kLocationList,
  );
}

//fuel type button type ios picker
Future <void> showFuelTypeActionSheet(BuildContext context) async {
  await showCupertinoModalPopup(
    context: context,
    builder: (context)=>CupertinoActionSheet(
      actions: [
        SizedBox(
          height: 150.0,
          child: buildFuelTypeCupertinoPicker(),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'),
        onPressed: ()=>Navigator.pop(context),
      ),
    ),);
  kFuelTypeListIndex;
  if(kFuelTypeListIndex == 0){
    selectedFuelType = 'diesel';
  } else {
    selectedFuelType = 'petrol';
  }
  //print('modal dismissed $kFuelTypeListIndex');
}
CupertinoPicker buildFuelTypeCupertinoPicker() {
  return CupertinoPicker(
    scrollController: fuelTypeCupertinoScrollController,
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: Colors.lightBlueAccent.withOpacity(0.3),
    ),
    itemExtent: 50.0,
    onSelectedItemChanged: (selectedIndex){
      kFuelTypeListIndex = selectedIndex;
      fuelTypeCupertinoScrollController.dispose();
      fuelTypeCupertinoScrollController = FixedExtentScrollController(initialItem: selectedIndex);
      //print(selectedIndex);
    }, children: kFuelTypeList,
  );
}

//fuel grade button ios picker (Petrol + Diesel)
Future<void> showPetrolTypeActionSheet (BuildContext context) async {
  await showCupertinoModalPopup(
    context: context,
    builder: (context)=>CupertinoActionSheet(
      actions: [
        SizedBox(
          height: 200.0,
          child: buildPetrolCupertinoPicker(),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'),
        onPressed: ()=>Navigator.pop(context),
      ),
    ),);

  if (selectedFuelType == 'petrol'){
    kFuelGradeListIndex;
    switch(kFuelGradeListIndex){
      case 0:
        selectedFuelGrade = '95 LRP';
        break;
      case 1:
        selectedFuelGrade = '95 unleaded';
        break;
      case 2:
        selectedFuelGrade = '93 unleaded';
        break;
    }
  } else if (selectedFuelType == 'diesel'){
    kFuelGradeListIndex;
    switch(kFuelGradeListIndex){
      case 0:
        selectedFuelGrade = '50 PPM';
        break;
      case 1:
        selectedFuelGrade = '500 PPM';
        break;
    }
  } else {
    print('from dropdown_picker => please select a fuel type first');
  }
  //print('octane is $selectedFuelGrade');
  //print('modal dismissed $selectedOctaneType');
  //getPetrolData(recordIndex: kLocationListIndex);
}
CupertinoPicker buildPetrolCupertinoPicker() {
  return CupertinoPicker(
    scrollController: petrolCupertinoScrollController,
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: Colors.lightBlueAccent.withOpacity(0.3),
    ),
    itemExtent: 50.0,
    onSelectedItemChanged: (selectedIndex){
      kFuelGradeListIndex = selectedIndex;
      petrolCupertinoScrollController.dispose();
      petrolCupertinoScrollController = FixedExtentScrollController(initialItem: selectedIndex);
      //print(selectedIndex);
    },
    children: selectedFuelType == 'petrol' ? kPetrolList : kDieselList,

  );
}


//location android dropdown
Widget buildAndroidLocationDropdown() {
  return DropdownButton<String>(
    value: ((kLocationList[0] as Center).child as Text).data,
    items: loopThroughLocationList(),
    onChanged: (value) {
      selectedLocation = value!;
      print('Selected location is $selectedLocation');
    },
  );
}
//location items loop
List<DropdownMenuItem<String>> loopThroughLocationList (){
  List<DropdownMenuItem<String>> dropdownLocationList = [];

  for(int i = 0; i< kLocationList.length; i++){
    String locationListText = ((kLocationList[i] as Center).child as Text).data!;
    //print(locationListText);
    var androidLocationItem = DropdownMenuItem(
      value: locationListText,
      child: Text(locationListText),
    );
    dropdownLocationList.add(androidLocationItem);
  }
  return dropdownLocationList;
}

//fuel type android dropdown
DropdownButton<String> buildAndroidFuelTypeDropdown() {
  return DropdownButton<String>(
    value: ((kFuelTypeList[0] as Center).child as Text).data,
    items: loopThroughFuelTypeList(),
    onChanged: (value){
        selectedFuelType = value!;
      print('Selected fuel type is $selectedFuelType');

    },
  );
}

//Fuel type Item
List<DropdownMenuItem<String>> loopThroughFuelTypeList(){
  List<DropdownMenuItem<String>> dropdownFuelTypeList = [];
  for(int i = 0; i < kFuelTypeList.length; i++){
    String fuelTypeListText = ((kFuelTypeList[i] as Center).child as Text).data!;
    //print(fuelTypeListText);
    var androidFuelTypeItem = DropdownMenuItem(
      value: fuelTypeListText,
        child: Text(fuelTypeListText),
    );
    dropdownFuelTypeList.add(androidFuelTypeItem);
  }
  return dropdownFuelTypeList;
}

//fuel type dropdown
