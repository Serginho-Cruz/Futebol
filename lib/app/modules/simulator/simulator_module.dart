import 'package:flutter_modular/flutter_modular.dart';
import 'package:futebol/app/modules/simulator/src/presenter/screens/group_screen.dart';
import 'src/data/usecases/Match/change_group_scoreboard_impl.dart';
import 'src/data/usecases/Match/get_matchs_by_group_impl.dart';
import 'src/data/usecases/Match/get_matchs_by_type_impl.dart';
import 'src/data/usecases/Selection/get_all_selections_impl.dart';
import 'src/data/usecases/Selection/get_selections_by_group_impl.dart';
import 'src/data/usecases/Selection/update_selection_statistics_impl.dart';
import 'src/presenter/controllers/match_store.dart';
import 'src/presenter/controllers/selection_store.dart';
import 'src/presenter/screens/home_screen.dart';

import 'src/external/datasources/sqlite/sqlite_datasource.dart';
import 'src/infra/repositories/match_repository_impl.dart';
import 'src/infra/repositories/selection_repository_impl.dart';

class SimulatorModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SQLitedatasource()),
    Bind.lazySingleton((i) => SelectionRepository(i())),
    Bind.lazySingleton((i) => MatchRepository(i())),
    Bind.lazySingleton((i) => UpdateSelectionsStatisticsUC(i())),
    Bind.lazySingleton((i) => GetAllSelectionsUC(i())),
    Bind.lazySingleton((i) => GetMatchsByGroupUC(i())),
    Bind.lazySingleton((i) => GetMatchsByTypeUC(i())),
    Bind.lazySingleton((i) => GetAllSelectionsUC(i())),
    Bind.lazySingleton((i) => GetSelectionsByGroupUC(i())),
    Bind.lazySingleton((i) => ChangeScoreboardUC(repository: i())),
    Bind.singleton(
      (i) => SelectionStore(
        getAll: i(),
        getByGroup: i(),
        updateStatistics: i(),
      ),
    ),
    Bind.singleton(
      (i) => MatchStore(
        getByType: i(),
        getByGroup: i(),
        changeScoreboard: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const HomeScreen()),
    ChildRoute(
      '/group',
      child: (context, args) => GroupScreen(group: args.data.toString()),
    ),
  ];
}
