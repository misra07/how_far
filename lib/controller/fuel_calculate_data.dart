// import 'package:flutter/material.dart';
// import 'home_view.dart';
//
// Future<void> updateAndCalculatePetrolDetails() async {
//   await Future.delayed(Duration(seconds: 1));
//
//   setState(() {
//     fuelPrice = petrolValue;
//     totalCost = (distance / consumption) *
//         fuelPrice;
//     totalCost = double.parse(
//         totalCost!.toStringAsFixed(2));
//     print('###FINAL fuel price => $fuelPrice and $petrolValue');
//   });
//
//   showModalBottomSheet(
//     context: context,
//     builder: buildBottomSheet,
//   );
//
//
// }