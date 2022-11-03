import 'package:flutter_modular/flutter_modular.dart';
import 'modules/simulator/simulator_module.dart';

class AppModule extends Module {
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> routes = [
    ModuleRoute('/', module: SimulatorModule()),
  ];
}
