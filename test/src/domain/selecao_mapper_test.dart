import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/src/domain/entities/selecao_entity.dart';
import 'package:futebol/src/domain/entities/selecao_mapper.dart';

void main() {
  group("Mappers are ok?", () {
    int id = 9;
    String bandeira = "bandeira", nome = "França", grupo = "C";

    var selecao = Selecao(id: id, nome: nome, bandeira: bandeira, grupo: grupo);

    test("Method toMap is working", () {
      var map = <String, dynamic>{
        'id': id,
        'bandeira': bandeira,
        'grupo': grupo,
        'nome': nome,
        'sg': 0,
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
