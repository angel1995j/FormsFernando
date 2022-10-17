import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({Key? key, required this.onPressed}) : super(key: key);
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    //TODO: implement Button widget
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Guardar'),
      ),
    );
  }
}
