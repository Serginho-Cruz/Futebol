import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/selection_factory.dart';
import 'package:futebol/helpers/soccer_match_factory.dart';
import 'package:futebol/src/data/usecases/change_scoreboards_impl.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../classes_mocks.dart';

void main() {
  final repository = MatchRepositoryMock();
  final usecase = ChangeScoreboard(repository);

  List<Selecao> selecoes = [
    FakeFactory.generateWithData(id: 1, gp: 3, gc: 3, pontos: 10, vitorias: 4),
    FakeFactory.generateWithData(id: 2, gp: 3, gc: 3, pontos: 4, vitorias: 2),
  ];

  group(
      "Change GC and GP only, when result is equal on previous and actual matchs",
      () {
    group("when Selection1 won the matchs", () {
      test("Change Correctly on Selection1", () async {
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match2 = MatchFactory.generateWithData(id: 2, score1: 3, score2: 0);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match2));

        final result = await usecase(
            matchId: 2, score1: 5, score2: 4, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.gp), equals(5));
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
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match2 = MatchFactory.generateWithData(id: 2, score1: 3, score2: 0);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match2));

        final result = await usecase(
            matchId: 2, score1: 5, score2: 4, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].gp), equals(7));
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
    group("when selection2 won the matchs", () {
      test("Change Correctly on Selection1", () async {
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match = MatchFactory.generateWithData(id: 2, score1: 0, score2: 3);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match));

        final result = await usecase(
            matchId: 2, score1: 4, score2: 5, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.gp), equals(7));
        expect(result.fold(id, (r) => r.first.gc), equals(5));
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
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match = MatchFactory.generateWithData(id: 2, score1: 0, score2: 3);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match));

        final result = await usecase(
            matchId: 2, score1: 4, score2: 5, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].gp), equals(5));
        expect(result.fold(id, (r) => r[1].gc), equals(7));
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

    group("When they draw in both matchs", () {
      test("Change Correctly in Selection1", () async {
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match = MatchFactory.generateWithData(id: 2, score1: 0, score2: 0);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match));

        final result = await usecase(
            matchId: 2, score1: 5, score2: 5, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.gp), equals(8));
        expect(result.fold(id, (r) => r.first.gc), equals(8));
        expect(
          result.fold(id, (r) => r.first.pontos),
          equals(selecoes.first.pontos),
        );
        expect(
          result.fold(id, (r) => r.first.vitorias),
          equals(selecoes.first.vitorias),
        );
      });
      test("Change Correctly in Selection2", () async {
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match = MatchFactory.generateWithData(id: 2, score1: 0, score2: 0);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match));

        final result = await usecase(
            matchId: 2, score1: 5, score2: 5, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].gp), equals(8));
        expect(result.fold(id, (r) => r[1].gc), equals(8));
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
  group("Change Values Correctly when a match draw and other not", () {
    group("When oldMatch was a draw", () {
      group("And Selection1 wins now", () {
        test("Changes correctly on Selection1", () async {
          when(() => repository.getSelectionByIds(any(), any()))
              .thenAnswer((_) async => Right(selecoes));

          var match =
              MatchFactory.generateWithData(id: 2, score1: 0, score2: 0);
          when(() => repository.getMatchById(any()))
              .thenAnswer((_) async => Right(match));

          var result = await usecase(
              matchId: 2,
              score1: 5,
              score2: 3,
              selectionId1: 1,
              selectionId2: 2);

          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r.first.gp), equals(8));
          expect(result.fold(id, (r) => r.first.gc), equals(6));
          expect(result.fold(id, (r) => r.first.pontos),
              equals(selecoes.first.pontos + 2));
          expect(result.fold(id, (r) => r.first.vitorias),
              equals(selecoes.first.vitorias + 1));
        });

        test("Changes correctly on Selection2", () async {
          when(() => repository.getSelectionByIds(any(), any()))
              .thenAnswer((_) async => Right(selecoes));

          var match =
              MatchFactory.generateWithData(id: 2, score1: 0, score2: 0);
          when(() => repository.getMatchById(any()))
              .thenAnswer((_) async => Right(match));

          var result = await usecase(
              matchId: 2,
              score1: 5,
              score2: 3,
              selectionId1: 1,
              selectionId2: 2);

          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r[1].gp), equals(6));
          expect(result.fold(id, (r) => r[1].gc), equals(8));
          expect(result.fold(id, (r) => r[1].pontos),
              equals(selecoes[1].pontos - 1));
          expect(result.fold(id, (r) => r[1].vitorias),
              equals(selecoes[1].vitorias));
        });
      });
      group("And Selection2 wins now", () {
        test("Changes correctly on Selection1", () async {
          when(() => repository.getSelectionByIds(any(), any()))
              .thenAnswer((_) async => Right(selecoes));

          var match =
              MatchFactory.generateWithData(id: 2, score1: 0, score2: 0);
          when(() => repository.getMatchById(any()))
              .thenAnswer((_) async => Right(match));

          var result = await usecase(
              matchId: 2,
              score1: 3,
              score2: 5,
              selectionId1: 1,
              selectionId2: 2);

          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r.first.gp), equals(6));
          expect(result.fold(id, (r) => r.first.gc), equals(8));
          expect(result.fold(id, (r) => r.first.pontos),
              equals(selecoes.first.pontos - 1));
          expect(result.fold(id, (r) => r.first.vitorias),
              equals(selecoes.first.vitorias));
        });

        test("Changes correctly on Selection2", () async {
          when(() => repository.getSelectionByIds(any(), any()))
              .thenAnswer((_) async => Right(selecoes));

          var match =
              MatchFactory.generateWithData(id: 2, score1: 0, score2: 0);
          when(() => repository.getMatchById(any()))
              .thenAnswer((_) async => Right(match));

          var result = await usecase(
              matchId: 2,
              score1: 3,
              score2: 5,
              selectionId1: 1,
              selectionId2: 2);

          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r[1].gp), equals(8));
          expect(result.fold(id, (r) => r[1].gc), equals(6));
          expect(result.fold(id, (r) => r[1].pontos),
              equals(selecoes[1].pontos + 2));
          expect(result.fold(id, (r) => r[1].vitorias),
              equals(selecoes[1].vitorias + 1));
        });
      });
    });
  });
  group("Change all values when winner is different on old and actual match",
      () {
    group("When Selection1 won the old match and lose now", () {
      test("Changes Correctly in Selection1", () async {
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match3 = MatchFactory.generateWithData(id: 2, score1: 2, score2: 1);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match3));

        final result = await usecase(
            matchId: 2, score1: 3, score2: 5, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.pontos),
            equals(selecoes.first.pontos - 3));
        expect(result.fold(id, (r) => r.first.vitorias),
            equals(selecoes.first.vitorias - 1));

        expect(result.fold(id, (r) => r.first.gp), equals(4));
        expect(result.fold(id, (r) => r.first.gc), equals(7));
      });
      test("Changes Correctly in Selection2", () async {
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match3 = MatchFactory.generateWithData(id: 2, score1: 2, score2: 1);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match3));

        final result = await usecase(
            matchId: 2, score1: 3, score2: 5, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].pontos),
            equals(selecoes[1].pontos + 3));
        expect(result.fold(id, (r) => r[1].vitorias),
            equals(selecoes[1].vitorias + 1));

        expect(result.fold(id, (r) => r[1].gp), equals(7));
        expect(result.fold(id, (r) => r[1].gc), equals(4));
      });
    });
    group("When Selection2 won the old match and lose now", () {
      test("Changes Correctly in Selection1", () async {
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match4 = MatchFactory.generateWithData(id: 2, score1: 3, score2: 4);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match4));

        final result = await usecase(
            matchId: 2, score1: 5, score2: 3, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.pontos),
            equals(selecoes.first.pontos + 3));
        expect(result.fold(id, (r) => r.first.vitorias),
            equals(selecoes.first.vitorias + 1));

        expect(result.fold(id, (r) => r.first.gp), equals(5));
        expect(result.fold(id, (r) => r.first.gc), equals(2));
      });
      test("Changes Correctly in Selection2", () async {
        when(() => repository.getSelectionByIds(any(), any()))
            .thenAnswer((_) async => Right(selecoes));

        var match4 = MatchFactory.generateWithData(id: 2, score1: 3, score2: 4);
        when(() => repository.getMatchById(any()))
            .thenAnswer((_) async => Right(match4));

        final result = await usecase(
            matchId: 2, score1: 5, score2: 3, selectionId1: 1, selectionId2: 2);

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].pontos),
            equals(selecoes[1].pontos - 3));
        expect(result.fold(id, (r) => r[1].vitorias),
            equals(selecoes[1].vitorias - 1));
        expect(result.fold(id, (r) => r[1].gp), equals(2));
        expect(result.fold(id, (r) => r[1].gc), equals(5));
      });
    });
  });
}
