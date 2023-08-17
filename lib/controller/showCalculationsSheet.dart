import 'package:flutter/material.dart';
import 'package:how_far/model/constants.dart';
import 'package:how_far/controller/picker_dropdown.dart';
import 'display_fields.dart';
import '../view/home_view.dart';

class TotalResultsSheet extends StatelessWidget {
  const TotalResultsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff020B16),
      child: Container(
        decoration: const BoxDecoration(
          //color: kColorLightShade,
          //color: Color(0xff2E3B52),
          image: DecorationImage(
              image:
              AssetImage('assets/multicolorShapeOnBlack.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )
        ),
        child: Center(
          //child: Text('$totalCost'),
          child: Stack(
            children: [
              Container(

                decoration: BoxDecoration (
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                    color: const Color(0xff05172e).withOpacity(0.8)
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                child: Column(
                  children: [
                    const Text('Travel Details',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300,
                        color: kColorWhiteFancy,
                      ),),
                    const Divider(
                      color: kColorWhiteFancy, // Customize the color of the divider
                      thickness: 1.0,      // Customize the thickness of the divider
                      indent: 16.0,        // Customize the indent (empty space before the divider starts)
                      endIndent: 16.0,     // Customize the end indent (empty space after the divider ends)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Padding(

                          padding: const EdgeInsets.all(5.0),
                          child: Container(

                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffA4C3CE), width: 1.00),


                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xffff7566).withOpacity(0.8)
                              //color: Color(0xff383855),
                            ),
                            child: Text(selectedLocation.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffffe8e5),

                              ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffff7566).withOpacity(0.8),
                              border: Border.all(color: const Color(0xffA4C3CE), width: 1.00),
                            ),
                            child: Text(selectedFuelType.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffffe8e5),
                              ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffff7566).withOpacity(0.8),
                              border: Border.all(color: const Color(0xffA4C3CE), width: 1.00),
                            ),
                            child: Text(selectedFuelGrade.replaceAll('unleaded', 'ULP').toUpperCase(),
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffffe8e5),
                              ),),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: kColorWhiteFancy, // Customize the color of the divider
                      thickness: 1.0,      // Customize the thickness of the divider
                      indent: 16.0,        // Customize the indent (empty space before the divider starts)
                      endIndent: 16.0,     // Customize the end indent (empty space after the divider ends)
                    ),
                    const SizedBox(height: 10.0),
                    Text('R $fuelPrice / Liter',
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: kColorWhiteFancy,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          TravelDetailsItem(title: 'Distance', text1: '$distance', text2: 'KM'),
                          const SizedBox(height: 10.0),
                          TravelDetailsItem(title: 'AVG Consumption', text1: '$consumption', text2: ' l/100km'),
                          const SizedBox(height: 10.0),
                          TravelDetailsItem(title: 'Travel Cost', text1: 'R ', text2: '$totalCost'),

                        ],
                      ),
                    ),
                    const SizedBox(),
                    Container(
                    )
                  ],

                ),
              )
            ],
          ),
        )
      )
    );
  }
}

class TravelDetailsItem extends StatelessWidget {
  final String title;
  final String text1;
  final String text2;

  const TravelDetailsItem({super.key, required this.title, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: kColorLightAccent,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10.00),
          buildSecondaryDisplayTextBold(enteredText: title),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSecondaryDisplayText(enteredText: text1),
              buildSecondaryDisplayText(enteredText: text2),
            ],
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}

void statusPrinter(){
  //print('bottom sheet raised');
}











