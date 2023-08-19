import 'package:flutter/material.dart';
import 'package:how_far/model/constants.dart';
//import 'package:how_far/model/theme.dart';

class PrimaryElevatedBTN extends StatelessWidget {

  final String btnText;
  final VoidCallback onPressed;

  const PrimaryElevatedBTN({super.key, required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
        //backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
        backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xffff6150)),
      ),
      onPressed: onPressed,
      child: Text(btnText.toUpperCase()),
    );
  }
}

class InfoElevatedBTN extends StatelessWidget {

  final String btnText;
  final VoidCallback onPressed;

  const InfoElevatedBTN({super.key, required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20, color: Colors.amber)),
        //backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
        backgroundColor: MaterialStatePropertyAll<Color>(kBtnColorSuccess.withOpacity(0.4)),
      ),
      onPressed: onPressed,
      child: Text(btnText.toUpperCase()),
    );
  }
}

class SuccessElevatedBTN extends StatelessWidget {

  final String btnText;
  final VoidCallback onPressed;

  const SuccessElevatedBTN({super.key, required this.btnText, required this.onPressed});

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

class WarningElevatedBTN extends StatelessWidget {

  final String btnText;
  final VoidCallback onPressed;

  const WarningElevatedBTN({super.key, required this.btnText, required this.onPressed});

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

class DangerElevatedBTN extends StatelessWidget {

  final String btnText;
  final VoidCallback onPressed;

  const DangerElevatedBTN({super.key, required this.btnText, required this.onPressed});

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

class DefaultElevatedBTN extends StatelessWidget {

  final String btnText;
  final VoidCallback onPressed;

  const DefaultElevatedBTN({super.key, required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(200.0, 50.0)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
        //backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
        backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xff3C4C6B)),
      ),
      onPressed: onPressed,
      child: Text(btnText.toUpperCase()),
    );
  }
}

