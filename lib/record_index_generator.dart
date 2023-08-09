import 'package:how_far/picker_dropdown.dart';

late int selectedRecordIndex;

void petrolRecordIndexGeneration() {
  if (selectedLocation == 'Reef'){
    switch (selectedFuelGrade){
      case '93 unleaded':
        selectedRecordIndex = 4;
        break;
      case '95 unleaded':
        selectedRecordIndex = 1;
        break;
    }
  } else if (selectedLocation == 'Coast'){
    switch (selectedFuelGrade){
      case '93 unleaded':
        selectedRecordIndex = 5;
        break;
      case '95 unleaded':
        selectedRecordIndex = 2;
        break;
    }
  }
}

//percentage 0.01 means 500PPM(0.05%)
void dieselRecordIndexGeneration() {
  if (selectedLocation == 'Reef'){
    switch(selectedFuelGrade){
      case '50 PPM':
        selectedRecordIndex = 2;
        break;
      case '500 PPM':
        selectedRecordIndex = 0;
        break;
    }
  } else if (selectedLocation == 'Coast'){
    switch(selectedFuelGrade){
      case '50 PPM':
        selectedRecordIndex = 3;
        break;
      case '500 PPM':
        selectedRecordIndex = 1;
        break;
    }
  }
}