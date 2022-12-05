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
        elevation: 10.0,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Center(
          child: Column(
            children: [
              ListTile(
                hoverColor: Colors.white,
                onTap: () {
                  _navigateTo('/');
                },
                horizontalTitleGap: 0.0,
                contentPadding: const EdgeInsets.only(top: 12.0),
                title: const Text(
                  "Home",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              ListTile(
                hoverColor: Colors.white,
                onTap: () {
                  _navigateTo('/round16');
                },
                title: const Text(
                  "Oitavas",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              ListTile(
                hoverColor: Colors.white,
                onTap: () {
                  _navigateTo('/quarters');
                },
                title: const Text(
                  "Quartas",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              ListTile(
                hoverColor: Colors.white,
                onTap: () {
                  _navigateTo('/finals');
                },
                title: const Text(
                  "Finais",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: const Text(
          'Simulador',
        ),
      ),
      body: widget.body,
    );
  }

  void _navigateTo(String route) {
    Navigator.popUntil(context, (route) => !Navigator.canPop(context));
    Modular.to.pushReplacementNamed(route);
  }
}
