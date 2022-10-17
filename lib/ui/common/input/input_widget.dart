import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  InputWidget({Key? key, required this.label, required this.controller})
      : super(key: key);
  String label;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        labelText: label,
      ),
    );
  }
}
