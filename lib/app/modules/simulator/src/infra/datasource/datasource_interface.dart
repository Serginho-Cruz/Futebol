import '../../domain/entities/Match/match_entity.dart';
import '../../domain/entities/Selection/selection_entity.dart';

abstract class IDataSource {
  Future<List<Selecao>> getAllSelections();
  Future<List<Selecao>> getSelectionsByGroup(String group);
  Future<Selecao> getSelectionById(int id);
  Future<List<SoccerMatch>> getMatchsByGroup(String group);
  Future<List<SoccerMatch>> getMatchsByType(int type);
  Future<SoccerMatch> getMatchById(int id);
  Future<List<int?>> changeScoreboard(SoccerMatch match);
  Future<List<Selecao>> getSelectionsByids(int id1, int id2);
  Future<List<Selecao>> updateSelectionsStatistics(
    List<Selecao> selections,
    String group,
  );
  Future<void> updateRound16({
    required List<Selecao> selections,
    required int idMatch1,
    required int idMatch2,
  });

  Future<void> updateNextPhase({
    required int idMatch,
    required int idSelection,
    required bool isId1,
  });
  Future<List<SoccerMatch>> getFinalMatchs();
  Future<void> restart();
}
