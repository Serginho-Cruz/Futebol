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
            fontFamily: 'Poppiuns',
            letterSpacing: 1.2,
          ),
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
            fontWeight: FontWeight.w400,
            fontSize: 26.0,
            fontFamily: 'Poppins',
            letterSpacing: 1.1,
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
