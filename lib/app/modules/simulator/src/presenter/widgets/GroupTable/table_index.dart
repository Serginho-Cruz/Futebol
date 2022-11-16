import 'package:flutter/material.dart';

class TableIndex extends StatelessWidget {
  final String text;

  const TableIndex({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
