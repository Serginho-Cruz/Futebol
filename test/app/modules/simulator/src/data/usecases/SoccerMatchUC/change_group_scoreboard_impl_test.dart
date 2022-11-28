import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/app/modules/simulator/src/data/usecases/Match/change_scoreboard_impl.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Match/match_entity.dart';
import 'package:mocktail/mocktail.dart';
import '../classes_mocks.dart';

void main() {
  final repository = MatchRepositoryMock();
  final usecase = ChangeScoreboardUC(repository: repository);

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
      const List<int> nums = [1, 1];

      when(() => repository.changeScoreboard(any()))
          .thenAnswer((_) async => const Right(nums));

      final result = await usecase(
        match: match,
        score1: 2,
        score2: 3,
      );

      expect(result.fold(id, id), isA<List<int>>());
      expect(result.fold(id, id), equals([1, 1]));
    });
  });
}
