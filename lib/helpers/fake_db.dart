import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/domain/selecao_mapper.dart';
import 'package:futebol/src/errors/errors.dart';
import 'selecao_factory.dart';

class FakeDB {
  late List<Selecao> selecoes;

  FakeDB({required int numSelecoes}) {
    selecoes = List.generate(numSelecoes, (_) => FakeFactory.generateSelecao());
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    if (selecoes.isEmpty) {
      throw EmptyList();
    }

    return selecoes.map((e) => SelecaoMapper.toMap(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getByGroup(String group) async {
    List<Map<String, dynamic>> list = List.empty(growable: true);
    if (selecoes.isEmpty) {
      throw EmptyList();
    }

    for (var element in selecoes) {
      if (element.grupo == group) {
        list.add(SelecaoMapper.toMap(element));
      }
    }

    if (list.isEmpty) {
      throw EmptyList("There's no Selecoes with this group");
    }
    return list;
  }

  Future<Map<String, dynamic>> getSelecaoById(int id) async {
    Selecao? selecao;
    if (selecoes.isEmpty) {
      throw EmptyList();
    }

    for (var element in selecoes) {
      if (element.id == id) {
        selecao = element;
        break;
      }
    }

    if (selecao == null) {
      throw SelecaoError("Selecao Don't found");
    } else {
      return SelecaoMapper.toMap(selecao);
    }
  }
}
