import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MatchPoint extends StatelessWidget {
  MatchPoint({super.key, required this.onChanged, required this.point});

  void Function(String) onChanged;
  final String? point;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: point,
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
