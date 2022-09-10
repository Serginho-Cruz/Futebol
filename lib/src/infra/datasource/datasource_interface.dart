import '../../domain/entities/Selection/selection_entity.dart';

abstract class IDataSource {
  Future<List<Selecao>> getAllSelections();
  Future<List<Selecao>> getSelectionsByGroup(String group);
  Future<Selecao> getSelectionById(int id);
}
