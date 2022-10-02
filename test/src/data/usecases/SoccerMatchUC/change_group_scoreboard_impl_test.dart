import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/selection_factory.dart';
import 'package:futebol/helpers/soccer_match_factory.dart';
import 'package:futebol/src/data/usecases/Match/change_group_scoreboard_impl.dart';
import 'package:futebol/src/domain/entities/Match/match_entity.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../classes_mocks.dart';

void main() {
  final repository = MatchRepositoryMock();
  final updateSelections = UpdateSelectionsMock();
  final usecase = ChangeGroupScoreboardUC(
      repository: repository, updateSelections: updateSelections);

  group("Usecase ChangeScoreboard is working rightly", () {
    late SoccerMatch match;

    setUpAll(() {
      match = const SoccerMatch(
        id: 1,
        idSelection1: 2,
        idSelection2: 4,
        local: '',
        date: '',
        hour: '',
        type: 1,
        score1: 2,
        score2: 3,
      );
      registerFallbackValue(match);
    });
    test("Returns the same selectionList that came from other usecase",
        () async {
      final selectionList =
          List.generate(2, (_) => FakeFactory.generateSelecao());

      when(() => repository.getMatchById(any()))
          .thenAnswer((_) async => Right(MatchFactory.generateMatch()));

      when(() => updateSelections(
              newScores: any(named: 'newScores'),
              oldScores: any(named: 'oldScores'),
              selectionId1: any(named: 'selectionId1'),
              selectionId2: any(named: 'selectionId2')))
          .thenAnswer((_) async => Right(selectionList));

      when(() => repository.changeScoreboard(any()))
          .thenAnswer((_) async => const Right(0));

      final result = await usecase(
        matchId: 2,
        score1: 2,
        score2: 3,
        selectionId1: 1,
        selectionId2: 3,
      );

      expect(result.fold(id, id), isA<List<Selecao>>());
      expect(result.fold(id, id), equals(selectionList));
    });
  });
}
