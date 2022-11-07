import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 30.0,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ListTile(
                  hoverColor: Colors.white,
                  onTap: () {
                    Navigator.popUntil(
                        context, (route) => !Navigator.canPop(context));

                    Modular.to.pushNamed('/');
                  },
                  title: const Text(
                    "Home",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Simulador',
        ),
      ),
      body: widget.body,
    );
  }
}
