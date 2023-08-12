import 'package:flutter/material.dart';
import 'package:how_far/model/constants.dart';
import 'package:how_far/model/theme.dart';

class primaryElevatedBTN extends StatelessWidget {

  late String btnText;
  late VoidCallback onPressed;

  primaryElevatedBTN({required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
        //backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
        backgroundColor: MaterialStatePropertyAll<Color>(AppTheme.buttons.btnColorPrimary),
      ),
      onPressed: onPressed,
      child: Text(btnText.toUpperCase()),
    );
  }
}

class infoElevatedBTN extends StatelessWidget {

  late String btnText;
  late VoidCallback onPressed;

  infoElevatedBTN({required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
        //backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
        backgroundColor: const MaterialStatePropertyAll<Color>(kBtnColorInfo),
      ),
      onPressed: onPressed,
      child: Text(btnText.toUpperCase()),
    );
  }
}

class successElevatedBTN extends StatelessWidget {

  late String btnText;
  late VoidCallback onPressed;

  successElevatedBTN({required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
        //backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
        backgroundColor: const MaterialStatePropertyAll<Color>(kBtnColorSuccess),
      ),
      onPressed: onPressed,
      child: Text(btnText.toUpperCase()),
    );
  }
}

class warningElevatedBTN extends StatelessWidget {

  late String btnText;
  late VoidCallback onPressed;

  warningElevatedBTN({required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
        //backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
        backgroundColor: const MaterialStatePropertyAll<Color>(kBtnColorWarning),
      ),
      onPressed: onPressed,
      child: Text(btnText.toUpperCase()),
    );
  }
}

class dangerElevatedBTN extends StatelessWidget {

  late String btnText;
  late VoidCallback onPressed;

  dangerElevatedBTN({required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
        //backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
        backgroundColor: const MaterialStatePropertyAll<Color>(kBtnColorDanger),
      ),
      onPressed: onPressed,
      child: Text(btnText.toUpperCase()),
    );
  }
}

class defaultElevatedBTN extends StatelessWidget {

  late String btnText;
  late VoidCallback onPressed;

  defaultElevatedBTN({required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
        //backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
        backgroundColor: const MaterialStatePropertyAll<Color>(kBtnColorDefault),
      ),
      onPressed: onPressed,
      child: Text(btnText.toUpperCase()),
    );
  }
}

