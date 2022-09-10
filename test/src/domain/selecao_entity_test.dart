import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';

void main() {
  group("Selecao Entity is ok?", () {
    int id = 8;
    String bandeira = "bandeira", nome = "Brasil", grupo = "A";
    var selecao = Selecao(
      id: id,
      nome: nome,
      bandeira: bandeira,
      grupo: grupo,
    );
    test("Types are correct", () {
      expect(selecao, isInstanceOf<Selecao>());
      expect(selecao.bandeira, isA<String>());
      expect(selecao.id, isA<int>());
      expect(selecao.nome, isA<String>());
      expect(selecao.pontos, isA<int>());
      expect(selecao.vitorias, isA<int>());
      expect(selecao.sg, isA<int>());
      expect(selecao.gc, isA<int>());
      expect(selecao.gp, isA<int>());
      expect(selecao.grupo, isA<String>());
    });

    test("Initial Values are correct", () {
      expect(selecao.id, equals(id));
      expect(selecao.nome, equals(nome));
      expect(selecao.bandeira, equals(bandeira));
      expect(selecao.grupo, equals(grupo));
      expect(selecao.gc, equals(0));
      expect(selecao.gp, equals(0));
      expect(selecao.sg, equals(0));
      expect(selecao.pontos, equals(0));
      expect(selecao.vitorias, equals(0));
    });
  });
}
