import 'package:how_far/picker_dropdown.dart';

late int selectedRecordIndex;

void recordIndexGeneration (){
  if (selectedLocation == 'Reef'){

    switch (selectedOctaneType){
      case '95 LRP':
        selectedRecordIndex = 0;
        break;
      case '93 unleaded':
        selectedRecordIndex = 1;
        break;
      case '95 unleaded':
        selectedRecordIndex = 4;
        break;
    }
  } else if (selectedLocation == 'Coast'){
    switch (selectedOctaneType){
      case '95 LRP':
        selectedRecordIndex = 3;
        break;
      case '93 unleaded':
        selectedRecordIndex = 2;
        break;
      case '95 unleaded':
        selectedRecordIndex = 5;
        break;
    }
  }
}