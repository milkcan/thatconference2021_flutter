import 'package:flutter/material.dart';

class ButtonFormLarge extends StatelessWidget {
  const ButtonFormLarge(
      {Key? key,
      required this.buttonText,
      required this.method,
      this.status = true})
      : super(key: key);

  static const textstyleButton =
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white);

  final String buttonText;
  final VoidCallback method;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 60,
        child: ElevatedButton(
            onPressed: status ? method : null,
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
            child: Text(buttonText, style: textstyleButton)));
  }
}
