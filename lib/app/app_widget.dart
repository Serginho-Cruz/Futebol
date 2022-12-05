import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromRGBO(80, 24, 55, 1),
          onPrimary: Colors.white,
          secondary: Color.fromRGBO(115, 18, 63, 1),
          onSecondary: Colors.white,
          error: Color.fromARGB(216, 209, 8, 4),
          onError: Colors.white,
          background: Color.fromARGB(135, 89, 21, 55),
          onBackground: Colors.white,
          surface: Color.fromARGB(255, 82, 15, 52),
          onSurface: Colors.white,
        ),
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
          backgroundColor: Color.fromARGB(92, 115, 18, 63),
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
