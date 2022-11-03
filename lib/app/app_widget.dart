import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Color.fromRGBO(217, 178, 130, 0.81),
            fontSize: 14.0,
          ),
        ),
        backgroundColor: const Color.fromARGB(135, 89, 21, 55),
        scaffoldBackgroundColor: const Color.fromARGB(135, 89, 24, 55),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 30.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
            ),
          ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26.0,
          ),
          iconTheme: IconThemeData(size: 45.0),
          backgroundColor: Color.fromARGB(155, 115, 18, 63),
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
