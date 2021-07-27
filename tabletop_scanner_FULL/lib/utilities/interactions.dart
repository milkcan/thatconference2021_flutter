import 'package:flutter/material.dart';
import 'package:tabletop_scanner/utilities/constants.dart';

void openScreen(screen, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void toastError(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: colorError,
    ),
  );
}

void toastSuccess(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: colorSuccess,
    ),
  );
}
