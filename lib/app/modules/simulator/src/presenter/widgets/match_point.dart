import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MatchPoint extends StatelessWidget {
  MatchPoint({super.key, required this.onChanged});

  void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        constraints: const BoxConstraints.tightFor(
          width: 35,
          height: 55,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      keyboardType: const TextInputType.numberWithOptions(
        decimal: false,
        signed: false,
      ),
      maxLength: 1,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardAppearance: Brightness.dark,
    );
  }
}
