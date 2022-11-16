import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/app/modules/simulator/helpers/selection_factory.dart';
import 'package:futebol/app/modules/simulator/src/data/usecases/Selection/define_group_winners_impl.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/app/modules/simulator/src/domain/usecases/Selection/define_group_winners_interface.dart';

void main() {
  final IDefineGroupWinners usecase = DefineGroupWinnersUC();

  test("Test 1 (no draws)", () {
    final List<Selecao> selections = [
      FakeFactory.generateWithData(id: 2, gp: 5, gc: 5, pontos: 9, vitorias: 4),
      FakeFactory.generateWithData(id: 3, gp: 5, gc: 5, pontos: 8, vitorias: 3),
      FakeFactory.generateWithData(id: 4, gp: 5, gc: 5, pontos: 6, vitorias: 2),
      FakeFactory.generateWithData(id: 5, gp: 5, gc: 5, pontos: 7, vitorias: 3),
    ];

    final result = usecase(selections);

    expect(result.first.id, equals(2));
    expect(result[1].id, equals(3));
  });

  test("Test 2 (draw with the firsts)", () {
    final List<Selecao> selections = [
      FakeFactory.generateWithData(
          id: 2, gp: 5, gc: 5, pontos: 10, vitorias: 4),
      FakeFactory.generateWithData(id: 3, gp: 5, gc: 5, pontos: 8, vitorias: 3),
      FakeFactory.generateWithData(id: 4, gp: 5, gc: 5, pontos: 7, vitorias: 2),
      FakeFactory.generateWithData(
          id: 5, gp: 5, gc: 4, pontos: 10, vitorias: 3),
    ];

    final result = usecase(selections);

    expect(result.first.id, equals(5));
    expect(result[1].id, equals(2));
  });
  test("Test 3 (first win and draw in second and third, resolved by SG)", () {
    final List<Selecao> selections = [
      FakeFactory.generateWithData(
          id: 2, gp: 5, gc: 5, pontos: 10, vitorias: 4),
      FakeFactory.generateWithData(id: 3, gp: 4, gc: 5, pontos: 8, vitorias: 3),
      FakeFactory.generateWithData(id: 4, gp: 3, gc: 5, pontos: 9, vitorias: 2),
      FakeFactory.generateWithData(id: 5, gp: 5, gc: 4, pontos: 9, vitorias: 3),
    ];

    final result = usecase(selections);

    expect(result.first.id, equals(2));
    expect(result[1].id, equals(5));
  });

  test("Test 4 (first win and draw in second and third, resolved by GP)", () {
    final List<Selecao> selections = [
      FakeFactory.generateWithData(id: 2, gp: 5, gc: 5, pontos: 9, vitorias: 4),
      FakeFactory.generateWithData(id: 3, gp: 6, gc: 6, pontos: 7, vitorias: 3),
      FakeFactory.generateWithData(id: 4, gp: 3, gc: 5, pontos: 4, vitorias: 2),
      FakeFactory.generateWithData(id: 5, gp: 4, gc: 4, pontos: 7, vitorias: 3),
    ];

    final result = usecase(selections);

    expect(result.first.id, equals(2));
    expect(result[1].id, equals(3));
  });
}
