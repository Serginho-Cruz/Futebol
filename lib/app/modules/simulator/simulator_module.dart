import 'package:flutter_modular/flutter_modular.dart';

import 'src/external/datasources/sqlite/sqlite_datasource.dart';
import 'src/infra/repositories/match_repository_impl.dart';
import 'src/infra/repositories/selection_repository_impl.dart';

class SimulatorModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SQLitedatasource()),
    Bind.lazySingleton((i) => SelectionRepository(i())),
    Bind.lazySingleton((i) => MatchRepository(i())),
  ];

  @override
  final List<ModularRoute> routes = [];
}
