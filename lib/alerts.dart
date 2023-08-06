import 'package:how_far/constants.dart';

import 'home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AndroidErrorAlert extends StatelessWidget {
final String errorMessage;
AndroidErrorAlert({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        )
      ],
      title: Text('Error'),
      contentPadding: EdgeInsets.all(20.0),
      content: Text(errorMessage),
      elevation: kDefaultElevation,
    );
  }
}


class iOSErrorAlert extends StatelessWidget {
  final String errorMessage;
  iOSErrorAlert({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
            print('Gesture detected');
          },
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Center(
          child: CupertinoAlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: [
              CupertinoDialogAction(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}

