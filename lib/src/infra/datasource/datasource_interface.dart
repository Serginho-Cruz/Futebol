import '../../domain/entities/Match/match_entity.dart';
import '../../domain/entities/Selection/selection_entity.dart';

abstract class IDataSource {
  Future<List<Selecao>> getAllSelections();
  Future<List<Selecao>> getSelectionsByGroup(String group);
  Future<Selecao> getSelectionById(int id);
  Future<List<SoccerMatch>> getMatchsByGroup(String group);
  Future<List<SoccerMatch>> getMatchsByType(int type);
}
