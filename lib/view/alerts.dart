import 'package:how_far/model/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AndroidErrorAlert extends StatelessWidget {
final String errorMessage;
const AndroidErrorAlert({super.key, required this.errorMessage});

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
      title: const Text('Error',
      style:TextStyle(
        color:kBtnColorDanger,
      ),),
      contentPadding: const EdgeInsets.all(20.0),
      content: Text(errorMessage),
      elevation: kDefaultElevation,
    );
  }
}


class IosErrorAlert extends StatelessWidget {
  final String errorMessage;
  const IosErrorAlert({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Center(
          child: CupertinoAlertDialog(
            title: const Text('Error',
              style: TextStyle(
                color: kBtnColorDanger,
              ),
            ),
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

// EXAMPLE
// showDialog(
// context: context as BuildContext, or simply "context"
// builder: (BuildContext context) {
// return IosErrorAlert(errorMessage: 'No internet connection /n. If you are on wifi, insure your wifi has internet connectivity and try again');
// }
// );




























