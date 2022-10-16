import 'package:futebol/app/modules/simulator/src/data/repository/match_repository_interface.dart';
import 'package:futebol/app/modules/simulator/src/data/repository/selection_repository_interface.dart';
import 'package:futebol/app/modules/simulator/src/domain/usecases/Selection/update_selection_statistics_interface.dart';
import 'package:mocktail/mocktail.dart';

class SelectionRepositoryMock extends Mock implements ISelectionRepository {}

class MatchRepositoryMock extends Mock implements IMatchRepository {}

class UpdateSelectionsMock extends Mock implements IUpdateSelectionStatistics {}
