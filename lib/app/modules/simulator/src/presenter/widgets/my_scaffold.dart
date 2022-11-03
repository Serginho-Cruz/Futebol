import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  MyScaffold({super.key, required this.body});

  Widget body;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simulador',
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: widget.body,
    );
  }
}
