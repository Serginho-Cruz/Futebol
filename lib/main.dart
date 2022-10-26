import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:futebol/app/app_module.dart';
import 'package:futebol/app/app_widget.dart';

void main() async {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
