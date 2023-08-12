import 'package:how_far/model/constants.dart';
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
          child: const Text('Close'),
        )
      ],
      title: const Text('Error'),
      contentPadding: const EdgeInsets.all(20.0),
      content: Text(errorMessage),
      elevation: kDefaultElevation,
    );
  }
}


class IosErrorAlert extends StatelessWidget {
  final String errorMessage;
  IosErrorAlert({required this.errorMessage});

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
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: [
              CupertinoDialogAction(
                child: const Text('Close'),
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

