import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/selection_factory.dart';
import 'package:futebol/src/data/usecases/Selection/update_selection_statistics_impl.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:mocktail/mocktail.dart';
import '../classes_mocks.dart';

void main() {
  final repository = SelectionRepositoryMock();
  final usecase = UpdateSelectionsStatisticsUC(repository);

  late List<Selecao> selecoes;

  setUp(() {
    selecoes = [
      FakeFactory.generateWithData(
          id: 1, gp: 3, gc: 3, pontos: 10, vitorias: 4),
      FakeFactory.generateWithData(id: 2, gp: 3, gc: 3, pontos: 4, vitorias: 2),
    ];
    when(() => repository.getSelectionByIds(any(), any()))
        .thenAnswer((_) async => Right(selecoes));
    when(() => repository.updateSelectionsStatistics(any()))
        .thenAnswer((_) async => const Right(1));
  });
  group(
      "Change GC and GP only, when result is equal on previous and actual matchs",
      () {
    group("when Selection1 won the matchs", () {
      test("Change Correctly on Selection1", () async {
        var result = await usecase(
          newScores: [5, 4],
          oldScores: [3, 0],
          selectionId1: 1,
          selectionId2: 2,
        );
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
        var result = await usecase(
          newScores: [5, 4],
          oldScores: [3, 0],
          selectionId1: 1,
          selectionId2: 2,
        );
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
        final result = await usecase(
          newScores: [4, 5],
          oldScores: [0, 3],
          selectionId1: 1,
          selectionId2: 2,
        );

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
        final result = await usecase(
          newScores: [4, 5],
          oldScores: [0, 3],
          selectionId1: 1,
          selectionId2: 2,
        );

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
        final result = await usecase(
            newScores: [5, 5],
            oldScores: [0, 0],
            selectionId1: 1,
            selectionId2: 2);

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
        final result = await usecase(
          newScores: [5, 5],
          oldScores: [0, 0],
          selectionId1: 1,
          selectionId2: 2,
        );

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
          var result = await usecase(
            newScores: [5, 3],
            oldScores: [0, 0],
            selectionId1: 1,
            selectionId2: 2,
          );

          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r.first.gp), equals(8));
          expect(result.fold(id, (r) => r.first.gc), equals(6));
          expect(result.fold(id, (r) => r.first.pontos),
              equals(selecoes.first.pontos + 2));
          expect(result.fold(id, (r) => r.first.vitorias),
              equals(selecoes.first.vitorias + 1));
        });

        test("Changes correctly on Selection2", () async {
          var result = await usecase(
            newScores: [5, 3],
            oldScores: [0, 0],
            selectionId1: 1,
            selectionId2: 2,
          );

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
          var result = await usecase(
            newScores: [3, 5],
            oldScores: [0, 0],
            selectionId1: 1,
            selectionId2: 2,
          );

          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r.first.gp), equals(6));
          expect(result.fold(id, (r) => r.first.gc), equals(8));
          expect(result.fold(id, (r) => r.first.pontos),
              equals(selecoes.first.pontos - 1));
          expect(result.fold(id, (r) => r.first.vitorias),
              equals(selecoes.first.vitorias));
        });

        test("Changes correctly on Selection2", () async {
          var result = await usecase(
            newScores: [3, 5],
            oldScores: [0, 0],
            selectionId1: 1,
            selectionId2: 2,
          );

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

    group("When actualMatch is a draw", () {
      group("And in oldMatch selection1 wins", () {
        test("Changes correctly in selection1", () async {
          var result = await usecase(
            newScores: [0, 0],
            oldScores: [2, 0],
            selectionId1: 1,
            selectionId2: 2,
          );
          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r.first.gp), equals(1));
          expect(result.fold(id, (r) => r.first.gc), equals(3));
          expect(result.fold(id, (r) => r.first.pontos),
              equals(selecoes.first.pontos - 2));
          expect(result.fold(id, (r) => r.first.vitorias),
              equals(selecoes.first.vitorias - 1));
        });

        test("Changes correctly in Selection2", () async {
          var result = await usecase(
            newScores: [0, 0],
            oldScores: [2, 0],
            selectionId1: 1,
            selectionId2: 2,
          );
          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r[1].gp), equals(3));
          expect(result.fold(id, (r) => r[1].gc), equals(1));
          expect(result.fold(id, (r) => r[1].pontos),
              equals(selecoes[1].pontos + 1));
          expect(result.fold(id, (r) => r[1].vitorias),
              equals(selecoes[1].vitorias));
        });
      });
      group("And in oldMatch selection2 wins", () {
        test("Changes correctly in selection1", () async {
          var result = await usecase(
            newScores: [0, 0],
            oldScores: [0, 2],
            selectionId1: 1,
            selectionId2: 2,
          );
          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r.first.gp), equals(3));
          expect(result.fold(id, (r) => r.first.gc), equals(1));
          expect(result.fold(id, (r) => r.first.pontos),
              equals(selecoes.first.pontos + 1));
          expect(result.fold(id, (r) => r.first.vitorias),
              equals(selecoes.first.vitorias));
        });

        test("Changes correctly in Selection2", () async {
          var result = await usecase(
            newScores: [0, 0],
            oldScores: [0, 2],
            selectionId1: 1,
            selectionId2: 2,
          );
          expect(result.fold(id, id), isA<List<Selecao>>());
          expect(result.fold(id, (r) => r[1].gp), equals(1));
          expect(result.fold(id, (r) => r[1].gc), equals(3));
          expect(result.fold(id, (r) => r[1].pontos),
              equals(selecoes[1].pontos - 2));
          expect(result.fold(id, (r) => r[1].vitorias),
              equals(selecoes[1].vitorias - 1));
        });
      });
    });
  });
  group("Change all values when winner is different on old and actual match",
      () {
    group("When Selection1 won the old match and lose now", () {
      test("Changes Correctly in Selection1", () async {
        final result = await usecase(
          newScores: [3, 5],
          oldScores: [2, 1],
          selectionId1: 1,
          selectionId2: 2,
        );

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.pontos),
            equals(selecoes.first.pontos - 3));
        expect(result.fold(id, (r) => r.first.vitorias),
            equals(selecoes.first.vitorias - 1));

        expect(result.fold(id, (r) => r.first.gp), equals(4));
        expect(result.fold(id, (r) => r.first.gc), equals(7));
      });
      test("Changes Correctly in Selection2", () async {
        final result = await usecase(
          newScores: [3, 5],
          oldScores: [2, 1],
          selectionId1: 1,
          selectionId2: 2,
        );

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
        final result = await usecase(
          newScores: [5, 3],
          oldScores: [3, 4],
          selectionId1: 1,
          selectionId2: 2,
        );

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.pontos),
            equals(selecoes.first.pontos + 3));
        expect(result.fold(id, (r) => r.first.vitorias),
            equals(selecoes.first.vitorias + 1));

        expect(result.fold(id, (r) => r.first.gp), equals(5));
        expect(result.fold(id, (r) => r.first.gc), equals(2));
      });
      test("Changes Correctly in Selection2", () async {
        final result = await usecase(
          newScores: [5, 3],
          oldScores: [3, 4],
          selectionId1: 1,
          selectionId2: 2,
        );

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

  group("When oldScores are null", () {
    group("And Selection1 wins", () {
      test("Changes correctly in Selection1", () async {
        var result = await usecase(
          newScores: [2, 1],
          oldScores: [null, null],
          selectionId1: 1,
          selectionId2: 2,
        );

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.pontos),
            equals(selecoes.first.pontos + 3));
        expect(result.fold(id, (r) => r.first.vitorias),
            equals(selecoes.first.vitorias + 1));
        expect(result.fold(id, (r) => r.first.gp), equals(5));
        expect(result.fold(id, (r) => r.first.gc), equals(4));
      });
      test("Changes correctly in Selection2", () async {
        var result = await usecase(
          newScores: [2, 1],
          oldScores: [null, null],
          selectionId1: 1,
          selectionId2: 2,
        );

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].pontos), equals(selecoes[1].pontos));
        expect(result.fold(id, (r) => r[1].vitorias),
            equals(selecoes[1].vitorias));
        expect(result.fold(id, (r) => r[1].gp), equals(4));
        expect(result.fold(id, (r) => r[1].gc), equals(5));
      });
    });

    group("And Selection2 wins", () {
      test("Changes correctly in Selection1", () async {
        var result = await usecase(
          newScores: [1, 2],
          oldScores: [null, null],
          selectionId1: 1,
          selectionId2: 2,
        );

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.pontos),
            equals(selecoes.first.pontos));
        expect(result.fold(id, (r) => r.first.vitorias),
            equals(selecoes.first.vitorias));
        expect(result.fold(id, (r) => r.first.gp), equals(4));
        expect(result.fold(id, (r) => r.first.gc), equals(5));
      });
      test("Changes correctly in Selection2", () async {
        var result = await usecase(
          newScores: [1, 2],
          oldScores: [null, null],
          selectionId1: 1,
          selectionId2: 2,
        );

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].pontos),
            equals(selecoes[1].pontos + 3));
        expect(result.fold(id, (r) => r[1].vitorias),
            equals(selecoes[1].vitorias + 1));
        expect(result.fold(id, (r) => r[1].gp), equals(5));
        expect(result.fold(id, (r) => r[1].gc), equals(4));
      });
    });

    group("And now was a draw", () {
      test("Changes correctly in Selection1", () async {
        var result = await usecase(
          newScores: [1, 1],
          oldScores: [null, null],
          selectionId1: 1,
          selectionId2: 2,
        );

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.first.pontos),
            equals(selecoes.first.pontos + 1));
        expect(result.fold(id, (r) => r.first.vitorias),
            equals(selecoes.first.vitorias));
        expect(result.fold(id, (r) => r.first.gp), equals(4));
        expect(result.fold(id, (r) => r.first.gc), equals(4));
      });
      test("Changes correctly in Selection2", () async {
        var result = await usecase(
          newScores: [1, 1],
          oldScores: [null, null],
          selectionId1: 1,
          selectionId2: 2,
        );

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r[1].pontos),
            equals(selecoes[1].pontos + 1));
        expect(result.fold(id, (r) => r[1].vitorias),
            equals(selecoes[1].vitorias));
        expect(result.fold(id, (r) => r[1].gp), equals(4));
        expect(result.fold(id, (r) => r[1].gc), equals(4));
      });
    });
  });
}
