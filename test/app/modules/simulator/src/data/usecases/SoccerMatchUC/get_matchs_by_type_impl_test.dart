import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/app/modules/simulator/helpers/soccer_match_factory.dart';
import 'package:futebol/app/modules/simulator/src/data/usecases/Match/get_matchs_by_type_impl.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Match/match_entity.dart';
import 'package:futebol/app/modules/simulator/src/errors/errors_classes/errors_classes.dart';
import 'package:mocktail/mocktail.dart';

import '../classes_mocks.dart';

void main() {
  group("Usecase GetMatchsByType is working rightly", () {
    final repository = MatchRepositoryMock();
    final usecase = GetMatchsByTypeUC(repository);

    test("Returns an error when repository answer that", () async {
      when(() => repository.getMatchsByType(any()))
          .thenAnswer((_) async => Left(DataSourceError('')));

      var result = await usecase(5);

      expect(result.fold(id, id), isA<Failure>());
      expect(result.fold(id, id), isA<DataSourceError>());
    });

    test("Returns a List of SoccerMatchs when works rightly", () async {
      const int type = 4;
      bool allTypesAreCorrect = true;
      when(() => repository.getMatchsByType(any())).thenAnswer((_) async =>
          Right(List.generate(4, (_) => MatchFactory.generateWithType(type))));

      var result = await usecase(type);

      result.fold(id, (r) {
        for (var match in r) {
          if (match.type != type) {
            allTypesAreCorrect = false;
            break;
          }
        }
      });

      expect(result.fold(id, id), isA<List<SoccerMatch>>());
      expect(result.fold(id, (r) => r.length), equals(4));
      expect(allTypesAreCorrect, isTrue);
    });
  });
}
