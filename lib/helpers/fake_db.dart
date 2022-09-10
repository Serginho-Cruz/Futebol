import '../src/domain/entities/Selection/selection_entity.dart';
import '../src/domain/entities/Selection/selection_mapper.dart';
import '../src/errors/errors_classes/errors_classes.dart';
import '../src/errors/errors_messages_classes/errors_messages.dart';
import 'selecao_factory.dart';

class FakeDB {
  late List<Selecao> selecoes;

  FakeDB({required int numSelecoes}) {
    selecoes = List.generate(numSelecoes, (_) => FakeFactory.generateSelecao());
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    if (selecoes.isEmpty) {
      throw EmptyList(Messages.noExistSelections);
    }

    return selecoes.map((e) => SelecaoMapper.toMap(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getByGroup(String group) async {
    List<Map<String, dynamic>> list = List.empty(growable: true);
    if (selecoes.isEmpty) {
      throw EmptyList(Messages.noExistSelections);
    }

    for (var element in selecoes) {
      if (element.grupo == group) {
        list.add(SelecaoMapper.toMap(element));
      }
    }

    if (list.isEmpty) {
      throw EmptyList(Messages.noGroupSelections);
    }
    return list;
  }

  Future<Map<String, dynamic>> getSelecaoById(int id) async {
    Selecao? selecao;
    if (selecoes.isEmpty) {
      throw EmptyList(Messages.noExistSelections);
    }

    for (var element in selecoes) {
      if (element.id == id) {
        selecao = element;
        break;
      }
    }

    if (selecao == null) {
      throw SelectionError(Messages.noSelectionFound);
    } else {
      return SelecaoMapper.toMap(selecao);
    }
  }
}
