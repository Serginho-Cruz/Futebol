import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/soccer_match_factory.dart';
import 'package:futebol/src/data/usecases/Match/get_matchs_by_group_impl.dart';
import 'package:futebol/src/domain/entities/Match/match_entity.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';
import 'package:mocktail/mocktail.dart';
import '../classes_mocks.dart';

void main() {
  group("Usecase GetMatchsByGroup is working", () {
    final repository = MatchRepositoryMock();
    final usecase = GetMatchsByGroupUC(repository);

    test("Returns an Error when repository answer that", () async {
      when(() => repository.getMatchsByGroup(any())).thenAnswer(
        (_) async => Left(DataSourceError('')),
      );

      var result = await usecase('A');

      expect(result.fold(id, id), isA<Failure>());
      expect(result.fold(id, id), isA<DataSourceError>());
    });

    test("Returns a List of SoccerMatch when no errors occur", () async {
      const String group = 'A';
      bool allGroupsAreEqual = true;
      when(() => repository.getMatchsByGroup(any())).thenAnswer((_) async =>
          Right(
              List.generate(4, (_) => MatchFactory.generateWithGroup(group))));

      var result = await usecase(group);

      result.fold(id, (r) {
        for (var element in r) {
          if (element.group != group) {
            allGroupsAreEqual = false;
            break;
          }
        }
      });

      expect(result.fold(id, id), isA<List<SoccerMatch>>());
      expect(result.fold(id, (r) => r.length), equals(4));
      expect(allGroupsAreEqual, isTrue);
    });
  });
}
