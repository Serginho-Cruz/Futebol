import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Selection/selection_mapper.dart';

void main() {
  group("Mappers are ok?", () {
    const int id = 9;
    const String bandeira = "bandeira", nome = "França", grupo = "C";

    var selecao =
        const Selecao(id: id, nome: nome, bandeira: bandeira, grupo: grupo);

    test("Method toMap is working", () {
      var map = <String, dynamic>{
        'id': id,
        'bandeira': bandeira,
        'grupo': grupo,
        'nome': nome,
        'gc': 0,
        'gp': 0,
        'pontos': 0,
        'vitorias': 0,
      };
      var result = SelecaoMapper.toMap(selecao);
      expect(result, isA<Map>());
      expect(result, equals(map));
    });

    test("Method fromMap is working", () {
      var result = SelecaoMapper.fromMap(SelecaoMapper.toMap(selecao));

      expect(result, isA<Selecao>());
      expect(result, equals(selecao));
    });
  });
}
