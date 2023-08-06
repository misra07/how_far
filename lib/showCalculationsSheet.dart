import 'package:flutter/material.dart';
import 'display_fields.dart';
import 'home_view.dart';

class TotalResultsSheet extends StatelessWidget {
  const TotalResultsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff737373),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )
        ),
        child: Center(
          //child: Text('$totalCost'),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
            child: Column(
              children: [
                Text('Travel Details',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),),
                Divider(
                  color: Colors.black, // Customize the color of the divider
                  thickness: 1.0,      // Customize the thickness of the divider
                  indent: 16.0,        // Customize the indent (empty space before the divider starts)
                  endIndent: 16.0,     // Customize the end indent (empty space after the divider ends)
                ),
                SizedBox(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      TravelDetailsItem(title: 'Distance', text1: '$distance', text2: 'KM'),
                      SizedBox(height: 20.0),
                      TravelDetailsItem(title: 'AVG Consumption', text1: '$consumption', text2: 'KM/L'),
                      SizedBox(height: 20.0),
                      TravelDetailsItem(title: 'Travel Cost', text1: 'R ', text2: '$totalCost'),
                    ],
                  ),
                ),
                SizedBox(),
                Container(
                  color: Colors.amber[200],
                )
              ],

            ),
          )
        )
      )
    );
  }
}

class TravelDetailsItem extends StatelessWidget {
  final String title;
  final String text1;
  final String text2;

  TravelDetailsItem({required this.title, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.redAccent[100],
          borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: Column(
        children: [
          SizedBox(height: 10.00),
          buildSecondaryDisplayTextBold(enteredText: title),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSecondaryDisplayText(enteredText: text1),
              buildSecondaryDisplayText(enteredText: text2),
            ],
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
