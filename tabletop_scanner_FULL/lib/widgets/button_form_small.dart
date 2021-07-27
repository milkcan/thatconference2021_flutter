import 'package:flutter/material.dart';

class ButtonFormSmall extends StatelessWidget {
  const ButtonFormSmall(
      {Key? key,
      required this.buttonText,
      required this.method,
      this.status = true})
      : super(key: key);

  static const textstyleButton = TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);

  final String buttonText;
  final VoidCallback method;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        height: 25,
        child: ElevatedButton(
            onPressed: status ? method : null,
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
            ),
            child: Text(buttonText, style: textstyleButton)));
  }
}
