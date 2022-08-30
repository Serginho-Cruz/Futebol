import '../../domain/selecao_entity.dart';

abstract class IDataSource {
  Future<List<Selecao>> getAllSelecoes();
  Future<List<Selecao>> getSelecaoByGroup(String group);
  Future<Selecao> getSelecaoById(int id);
}
