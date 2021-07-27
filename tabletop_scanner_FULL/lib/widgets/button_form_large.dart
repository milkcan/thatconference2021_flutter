import 'package:flutter/material.dart';

class ButtonFormLarge extends StatelessWidget {
  const ButtonFormLarge(
      {Key? key,
      required this.buttonText,
      required this.method,
      this.status = true,
      this.reverseColors = false})
      : super(key: key);

  static const COLOR_PRIMARY = Colors.blue;
  static const COLOR_SECONDARY = Colors.white;

  final String buttonText;
  final VoidCallback method;
  final bool status;
  final bool reverseColors;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = COLOR_PRIMARY;
    Color onPrimaryColor = COLOR_SECONDARY;

    if (this.reverseColors) {
      primaryColor = COLOR_SECONDARY;
      onPrimaryColor = COLOR_PRIMARY;
    }

    var textstyleButton = TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: onPrimaryColor);

    return SizedBox(
        width: 300,
        height: 60,
        child: ElevatedButton(
            onPressed: status ? method : null,
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              onPrimary: onPrimaryColor,
            ),
            child: Text(buttonText, style: textstyleButton)));
  }
}
