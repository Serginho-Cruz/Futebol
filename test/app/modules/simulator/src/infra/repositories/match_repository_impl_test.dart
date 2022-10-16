import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/app/modules/simulator/helpers/soccer_match_factory.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Match/match_entity.dart';
import 'package:futebol/app/modules/simulator/src/errors/errors_classes/errors_classes.dart';
import 'package:futebol/app/modules/simulator/src/infra/repositories/match_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import 'datasource_mock.dart';

void main() {
  final datasource = DataSourceMock();
  final repository = MatchRepository(datasource);

  const String msg = '';

  group("Match Repository is working rightly", () {
    group("Method getMatchByType is working", () {
      test("Returns a List of Matchs when no errors occur", () async {
        var list = List.generate(8, (_) => MatchFactory.generateWithType(4));
        when(() => datasource.getMatchsByType(any()))
            .thenAnswer((_) async => list);

        var result = await repository.getMatchsByType(2);

        expect(result.isRight(), isTrue);
        expect(result.fold(id, id), isA<List<SoccerMatch>>());
        expect(result.fold(id, id), equals(list));
      });
      test("Returns a Failure when datasource throws", () async {
        when(() => datasource.getMatchsByType(any()))
            .thenThrow(NoMatchsFound(msg));

        var result = await repository.getMatchsByType(2);

        expect(result.isLeft(), isTrue);
        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold((l) => l.toString(), id), equals(msg));
      });
    });
    group("Method getMtachByGroup is working", () {
      test("Returns a List of Matchs when no errors occur", () async {
        var list = List.generate(6, (_) => MatchFactory.generateWithGroup('A'));

        when(() => datasource.getMatchsByGroup(any()))
            .thenAnswer((_) async => list);

        var result = await repository.getMatchsByGroup('A');

        expect(result.isRight(), isTrue);
        expect(result.fold(id, id), isA<List<SoccerMatch>>());
        expect(result.fold(id, id), equals(list));
      });
      test("Returns a Failure when datasource throws", () async {
        when(() => datasource.getMatchsByGroup(any()))
            .thenThrow(NoMatchsFound(msg));

        var result = await repository.getMatchsByGroup('A');

        expect(result.isLeft(), isTrue);
        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold((l) => l.toString(), id), equals(msg));
      });
    });
    group("Method getMatchById is working", () {
      test("Returns a Match when no errors occur", () async {
        var match = MatchFactory.generateWithData(score1: 3, score2: 2, id: 1);

        when(() => datasource.getMatchById(any()))
            .thenAnswer((_) async => match);

        var result = await repository.getMatchById(1);

        expect(result.isRight(), isTrue);
        expect(result.fold(id, id), isA<SoccerMatch>());
        expect(result.fold(id, id), equals(match));
      });
      test("Returns a Failure when datasource throws", () async {
        when(() => datasource.getMatchById(any())).thenThrow(NoMatchFound(msg));

        var result = await repository.getMatchById(1);

        expect(result.isLeft(), isTrue);
        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold((l) => l.toString(), id), equals(msg));
      });
    });
    group("Method changeScoreboard is working", () {
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
      test("Returns an int when no errors occur", () async {
        when(() => datasource.changeScoreboard(any()))
            .thenAnswer((_) async => [1, 1]);

        var result = await repository.changeScoreboard(match);

        expect(result.isRight(), isTrue);
        expect(result.fold(id, id), isA<List<int>>());
        expect(result.fold(id, id), equals([1, 1]));
      });
      test("Returns a Failure when datasource throws", () async {
        when(() => datasource.changeScoreboard(any()))
            .thenThrow(DataSourceError(msg));

        var result = await repository.changeScoreboard(match);

        expect(result.isLeft(), isTrue);
        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold((l) => l.toString(), id), equals(msg));
      });
    });
  });
}
