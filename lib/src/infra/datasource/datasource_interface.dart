import '../../domain/entities/Match/match_entity.dart';
import '../../domain/entities/Selection/selection_entity.dart';

abstract class IDataSource {
  Future<List<Selecao>> getAllSelections();
  Future<List<Selecao>> getSelectionsByGroup(String group);
  Future<Selecao> getSelectionById(int id);
  Future<List<SoccerMatch>> getMatchsByGroup(String group);
  Future<List<SoccerMatch>> getMatchsByType(int type);
  Future<SoccerMatch> getMatchById(int id);
  Future<int> changeScoreboard(SoccerMatch newMatch);
  Future<List<Selecao>> getSelectionsByids(List<int> ids);
  Future<int> updateSelectionsStatistics(List<Selecao> selections);
}
