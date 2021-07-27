import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon(
      {Key? key, required this.icon, required this.method, this.status = true})
      : super(key: key);

  final Icon icon;
  final VoidCallback method;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 60,
        height: 40,
        child: ElevatedButton(
            onPressed: status ? method : null,
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
            child: this.icon));
  }
}
