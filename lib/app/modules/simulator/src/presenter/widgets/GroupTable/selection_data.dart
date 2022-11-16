import 'package:flutter/material.dart';

class SelectionData extends StatelessWidget {
  final String text;
  const SelectionData({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
