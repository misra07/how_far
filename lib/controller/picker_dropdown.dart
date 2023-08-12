
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/constants.dart';
import '../view/home_view.dart';

String selectedLocation = 'Inland';
String selectedFuelType = '';
String selectedFuelGrade = 'none';

//iOS button pickers
var locationCupertinoScrollController = FixedExtentScrollController(initialItem: kLocationListIndex);
var fuelTypeCupertinoScrollController = FixedExtentScrollController(initialItem: kFuelTypeListIndex);
var petrolCupertinoScrollController = FixedExtentScrollController(initialItem: kFuelGradeListIndex);


//1. iOS - location picker Modal
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
        child: const Text('Cancel'),
        onPressed: ()=>Navigator.pop(context),
      ),
    ),
  );
  //print('final selected location index is $kLocationListIndex');
  kLocationListIndex;
  if (kLocationListIndex == 0){
    selectedLocation = 'Inland';
  } else {
    selectedLocation = 'Coast';
  }

}
//1. iOS - location picker CupertinoPicker
CupertinoPicker buildLocationCupertinoPicker() {
  return CupertinoPicker(
    scrollController: locationCupertinoScrollController,
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: kColorDarkAccent.withOpacity(0.6),
    ),
    itemExtent: 50,
    onSelectedItemChanged: (selectedIndex){
      kLocationListIndex = selectedIndex;
      locationCupertinoScrollController.dispose();
      locationCupertinoScrollController = FixedExtentScrollController(initialItem: kLocationListIndex);
      locationSelectorLabel = ((kLocationList[kLocationListIndex] as Center).child as Text).data!;
      //print('the selected index is $kLocationListIndex from picker_dropdown $locationSelectorLabel');


    }, children: kLocationList,
  );
}

//2. iOS - fuel type picker Modal
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
        child: const Text('Cancel'),
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
//2. iOS - fuel type picker CupertinoPicker
CupertinoPicker buildFuelTypeCupertinoPicker() {
  return CupertinoPicker(
    scrollController: fuelTypeCupertinoScrollController,
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: kColorDarkAccent.withOpacity(0.6),
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

//3. iOS - fuel grade picker Modal (petrol + diesel)
Future<void> showFuelGradeActionSheet (BuildContext context) async {
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
        child: const Text('Cancel'),
        onPressed: ()=>Navigator.pop(context),
      ),
    ),);

  if (selectedFuelType == 'petrol'){
    kFuelGradeListIndex;
    switch(kFuelGradeListIndex){
      case 1:
        selectedFuelGrade = '93 unleaded';
        break;
      case 0:
        selectedFuelGrade = '95 unleaded';
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
    //print('from dropdown_picker => please select a fuel type first');
  }
  //print('octane is $selectedFuelGrade');
  //print('modal dismissed $selectedOctaneType');
  //getPetrolData(recordIndex: kLocationListIndex);
}
//3. iOS - fuel grade picker CupertinoPicker
CupertinoPicker buildPetrolCupertinoPicker() {
  return CupertinoPicker(
    scrollController: petrolCupertinoScrollController,
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: kColorDarkAccent.withOpacity(0.6),
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



//1. Android - location dropdown
Widget buildAndroidLocationDropdown({required Function updateValueAndUI}) {

  return DropdownButton<String>(
    value: selectedLocation,
    style: const TextStyle(color: kColorBlackFancy, fontSize: 20.0),
    dropdownColor: kColorLightAccent,
    items: loopThroughLocationList(),
    onChanged: (value) {
      selectedLocation = value!;
      updateValueAndUI();
      //print('Selected location is $selectedLocation');
    },
  );
}
//1. Android - location dropdown items - loop
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

//2. Android - fuel type dropdown
DropdownButton<String> buildAndroidFuelTypeDropdown({required Function updateValueAndUI}) {

  return DropdownButton<String>(

    value: selectedFuelType.isEmpty? 'petrol': selectedFuelType,
    items: loopThroughFuelTypeList(),
    style: const TextStyle(color: kColorBlackFancy, fontSize: 20.0),
    dropdownColor: kColorLightAccent,
    onChanged: (value){
      selectedFuelType = value!;
      updateValueAndUI();
      //print('Selected fuel type is $selectedFuelType');
    },
  );
}
//2. Android - fuel type dropdown items - loop
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

//3. Android - fuel grade dropdown
int fuelGradeIndex = 0;
bool isPetrol = true;
DropdownButton<String> buildAndroidFuelGradeDropdown({required Function updateiOSValueAndUI}) {
  if(selectedFuelType == ''){
    selectedFuelType = 'petrol';
  }
  return DropdownButton<String>(
    value: selectedFuelType == 'petrol'? ((kPetrolList[fuelGradeIndex] as Center).child as Text).data: ((kDieselList[fuelGradeIndex] as Center).child as Text).data,
    items: selectedFuelType == 'petrol'? loopThroughPetrolList(): loopThroughDieselList(),
    style: const TextStyle(color: kColorBlackFancy, fontSize: 20.0),
    dropdownColor: kColorLightAccent,
    onChanged: (value){
      selectedFuelGrade = value!;
      if(selectedFuelType == 'petrol'){

        switch(selectedFuelGrade){
          case '93 unleaded':
            fuelGradeIndex = 1;
          case '95 unleaded':
            fuelGradeIndex = 0;
        }
      } else if(selectedFuelType == 'diesel'){
        switch (selectedFuelGrade){
          case '50 PPM':
            fuelGradeIndex = 0;
          case '500 PPM':
              fuelGradeIndex = 1;
          }
        }
      updateiOSValueAndUI();
    },
  );

}

//3. Android - fuel type dropdown items - loop (petrol)
List<DropdownMenuItem<String>> loopThroughPetrolList(){
  List<DropdownMenuItem<String>> dropdownPetrolList = [];
  for(int i = 0; i < kPetrolList.length; i++){
    String fuelGradeListText = ((kPetrolList[i] as Center).child as Text).data!;
    //print(fuelGradeListText);
    var androidFuelGradeItem = DropdownMenuItem(
      value: fuelGradeListText,
      child: Text(fuelGradeListText),
    );
    dropdownPetrolList.add(androidFuelGradeItem);
  }
  return dropdownPetrolList;
}
//3. Android - fuel type dropdown items - loop (petrol)
List<DropdownMenuItem<String>> loopThroughDieselList(){
  List<DropdownMenuItem<String>> dropdownDieselList = [];
  for(int i = 0; i < kDieselList.length; i++){
    String fuelGradeListText = ((kDieselList[i] as Center).child as Text).data!;
    //print(fuelGradeListText);
    var androidFuelGradeItem = DropdownMenuItem(
      value: fuelGradeListText,
      child: Text(fuelGradeListText),
    );
    dropdownDieselList.add(androidFuelGradeItem);
  }
  return dropdownDieselList;
}