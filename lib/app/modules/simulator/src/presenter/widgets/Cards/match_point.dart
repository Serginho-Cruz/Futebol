import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MatchPoint extends StatefulWidget {
  const MatchPoint({
    super.key,
    required this.onChanged,
    required this.point,
    required this.focus,
    required this.onSubmit,
    this.enabled = true,
  });

  final void Function(String) onChanged;
  final String? point;
  final FocusNode focus;
  final void Function() onSubmit;
  final bool enabled;

  @override
  State<MatchPoint> createState() => _MatchPointState();
}

class _MatchPointState extends State<MatchPoint> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.point);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      enabled: widget.enabled,
      showCursor: false,
      focusNode: widget.focus,
      onEditingComplete: widget.onSubmit,
      onChanged: widget.onChanged,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(fontSize: 12.0, color: Colors.black),
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        contentPadding: const EdgeInsets.only(left: 2),
        fillColor: Colors.white,
        constraints: const BoxConstraints.tightFor(
          width: 30,
          height: 30,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
