import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/selection_factory.dart';
import 'package:futebol/helpers/soccer_match_factory.dart';
import 'package:futebol/src/data/usecases/change_scoreboards_impl.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:mockito/mockito.dart';

import '../repository.mocks.dart';

void main() {
  final repository = MockRepositoryMock();
  final usecase = ChangeScoreboard(repository);

  List<Selecao> selecoes = [
    FakeFactory.generateWithData(id: 1, gp: 5, gc: 5, pontos: 10, vitorias: 4),
    FakeFactory.generateWithData(id: 2, gp: 2, gc: 3, pontos: 5, vitorias: 2),
  ];

  when(repository.getSelectionByIds(any, any))
      .thenAnswer((_) async => Right(selecoes));

  group(
      "Chagne Gc and GP only, when result is equal on previous and actual matchs",
      () {
    group("when selection2 won the matchs", () {
      var match = MatchFactory.generateWithData(score1: 2, score2: 4);
      when(repository.getMatchById(any)).thenAnswer((_) async => Right(match));

      test("Change Correctly on Selection1", () async {
        final result = await usecase(
            matchId: 2, score1: 4, score2: 5, selectionId1: 2, selectionId2: 5);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.gp), equals(7));
        expect(result.fold(id, (r) => r.first.gc), equals(6));
        expect(
          result.fold(id, (r) => r.first.pontos),
          equals(selecoes.first.pontos),
        );
        expect(
          result.fold(id, (r) => r.first.vitorias),
          equals(selecoes.first.vitorias),
        );
      });

      test("Change Correctly on Selection2", () async {
        final result = await usecase(
            matchId: 2, score1: 4, score2: 5, selectionId1: 2, selectionId2: 5);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].gp), equals(3));
        expect(result.fold(id, (r) => r[1].gc), equals(5));
        expect(
          result.fold(id, (r) => r[1].pontos),
          equals(selecoes[1].pontos),
        );
        expect(
          result.fold(id, (r) => r[1].vitorias),
          equals(selecoes[1].vitorias),
        );
      });
    });

    group("when Selection1 won the matchs", () {
      var match = MatchFactory.generateWithData(score1: 4, score2: 2);
      when(repository.getMatchsByType(any))
          .thenAnswer((_) async => Right([match]));

      test("Change Correctly on Selection1", () async {
        final result = await usecase(
            matchId: 2, score1: 5, score2: 4, selectionId1: 2, selectionId2: 5);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.gp), equals(6));
        expect(result.fold(id, (r) => r.first.gc), equals(7));
        expect(
          result.fold(id, (r) => r.first.pontos),
          equals(selecoes.first.pontos),
        );
        expect(
          result.fold(id, (r) => r.first.vitorias),
          equals(selecoes.first.vitorias),
        );
      });
      test("Change Correctly on Selection2", () async {
        final result = await usecase(
            matchId: 2, score1: 5, score2: 4, selectionId1: 2, selectionId2: 5);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].gp), equals(4));
        expect(result.fold(id, (r) => r[1].gc), equals(4));
        expect(
          result.fold(id, (r) => r[1].pontos),
          equals(selecoes[1].pontos),
        );
        expect(
          result.fold(id, (r) => r[1].vitorias),
          equals(selecoes[1].vitorias),
        );
      });
    });
  });

  group("Change all values when winner is different on old and actual match",
      () {
    group("When Selection1 won the old match and lose now", () {
      var match = MatchFactory.generateWithData(score1: 2, score2: 1);
      when(repository.getMatchsByType(any))
          .thenAnswer((_) async => Right([match]));
      test("Changes Correctly in Selection1", () async {
        final result = await usecase(
            matchId: 2, score1: 3, score2: 5, selectionId1: 5, selectionId2: 6);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.pontos),
            equals(selecoes.first.pontos - 3));
        expect(result.fold(id, (r) => r.first.vitorias),
            equals(selecoes.first.vitorias - 1));

        expect(result.fold(id, (r) => r.first.gp), equals(6));
        expect(result.fold(id, (r) => r.first.gc), equals(9));
      });
      test("Changes Correctly in Selection2", () async {
        final result = await usecase(
            matchId: 2, score1: 3, score2: 5, selectionId1: 5, selectionId2: 6);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].pontos),
            equals(selecoes[1].pontos + 3));
        expect(result.fold(id, (r) => r[1].vitorias),
            equals(selecoes[1].vitorias + 1));

        expect(result.fold(id, (r) => r[1].gp), equals(6));
        expect(result.fold(id, (r) => r[1].gc), equals(4));
      });
    });
  });
}
