import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:futebol/app/modules/simulator/src/presenter/controllers/match_store.dart';

import '../utils/colors.dart';

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
        backgroundColor: MyColors.normalPurple,
        elevation: 10.0,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _createTile(
                    route: '/home',
                    tileTitle: 'Home',
                    padding: const EdgeInsets.only(top: 14.0),
                  ),
                  _createTile(route: '/round16', tileTitle: 'Oitavas'),
                  _createTile(route: '/quarters', tileTitle: 'Quartas'),
                  _createTile(route: '/finals', tileTitle: 'Finais'),
                ],
              ),
              _createTile(
                route: '/',
                tileTitle: 'Restart',
                padding: const EdgeInsets.only(bottom: 15.0),
                onTap: () {
                  Modular.get<MatchStore>().restart();
                  _navigateTo('/');
                },
              ),
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
          'Simulador 2022',
        ),
      ),
      body: widget.body,
    );
  }

  void _navigateTo(String route) {
    Navigator.popUntil(context, (route) => !Navigator.canPop(context));
    Modular.to.pushReplacementNamed(route);
  }

  ListTile _createTile({
    required String route,
    required String tileTitle,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    void Function()? onTap,
  }) {
    return ListTile(
      hoverColor: Colors.white,
      title: Text(
        tileTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          letterSpacing: 1.1,
        ),
      ),
      contentPadding: padding,
      onTap: onTap ?? () => _navigateTo(route),
    );
  }
}
