import 'dart:isolate';

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

// EXAMPLE
// showDialog(
// context: context as BuildContext, or simply "context"
// builder: (BuildContext context) {
// return IosErrorAlert(errorMessage: 'No internet connection /n. If you are on wifi, insure your wifi has internet connectivity and try again');
// }
// );




void main() {
  // Create a ReceivePort for receiving messages from the isolate
  final receivePort = ReceivePort();

  // Spawn a new isolate and pass it the receive port
  Isolate.spawn(backgroundTask, receivePort.sendPort);

  // Receive and process messages from the isolate
  receivePort.listen((message) {
    print('Received message from isolate: $message');
  });
}

void backgroundTask(SendPort sendPort) {
  // Perform background work here
  for (int i = 0; i < 5; i++) {
    sendPort.send('Task $i completed');
  }

  // Close the isolate's send port when done
  sendPort.send('Task completed');
  //sendPort.close();
}























