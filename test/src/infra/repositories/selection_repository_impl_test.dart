import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/selection_factory.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';
import 'package:futebol/src/infra/repositories/selection_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import 'datasource_mock.dart';

void main() {
  final datasource = DataSourceMock();
  final repository = SelectionRepository(datasource);

  late String message;

  setUp(() {
    message = "";
  });

  group("Selection Repository is working rightly", () {
    group("Method getAllSelections is working", () {
      test("Returns a List of Selecao when datasource answer that", () async {
        var list = List.generate(10, (_) => FakeFactory.generateSelecao());
        when(() => datasource.getAllSelections()).thenAnswer((_) async => list);

        var result = await repository.getAllSelections();

        expect(result.isRight(), isTrue);
        expect(result.fold(id, id), isA<List>());
        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, id), equals(list));
      });

      test("Returns a Failure when datasource throw that", () async {
        when(() => datasource.getAllSelections())
            .thenThrow(DataSourceError(message));

        var result = await repository.getAllSelections();

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold((l) => l.toString(), id), equals(message));
      });
    });

    group("Method getSelectionsByGroup is working", () {
      test("Returns a List of Selections when no errors occur", () async {
        var list =
            List.generate(4, (_) => FakeFactory.generateSelecaoWithGroup('A'));
        when(() => datasource.getSelectionsByGroup(any()))
            .thenAnswer((_) async => list);

        var result = await repository.getSelectionsByGroup("A");

        expect(result.isRight(), isTrue);
        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, id), equals(list));
      });
      test("Returns a Failure when datasource throws that", () async {
        when(() => datasource.getSelectionsByGroup(any()))
            .thenAnswer((_) async => throw NoSelectionsFound(message));

        var result = await repository.getSelectionsByGroup("A");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold((l) => l.toString(), id), equals(message));
      });
    });
    group("Method getSelecao is working", () {
      test("Returns a Selecao when no errors occur", () async {
        when(() => datasource.getSelectionById(any()))
            .thenAnswer((_) async => FakeFactory.generateSelecao());

        var result = await repository.getSelection(10);

        expect(result.isRight(), isTrue);
        expect(result.fold(id, id), isA<Selecao>());
      });

      test("Returns a Failure when datasource throws that", () async {
        when(() => datasource.getSelectionById(any()))
            .thenAnswer((_) async => throw DataSourceError(message));

        var result = await repository.getSelection(5);

        expect(result.fold(id, id), isA<Failure>());

        expect(result.fold((l) => l.toString(), id), equals(message));
      });
    });
    group("Method getSelectionsByIds is working", () {
      test("Returns a list of Selections when no errors occur", () async {
        var list = List.generate(2, (_) => FakeFactory.generateSelecao());
        when(() => datasource.getSelectionsByids(any()))
            .thenAnswer((_) async => list);

        var result = await repository.getSelectionsByIds([1, 2]);

        expect(result.isRight(), isTrue);
        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, id), equals(list));
      });
      test("Returns a Failure when datasource throws that", () async {
        when(() => datasource.getSelectionsByids(any()))
            .thenThrow(DataSourceError(message));

        var result = await repository.getSelectionsByIds([1, 2]);
        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold((l) => l.toString(), id), equals(message));
      });
    });

    group("Method updateSelectionsStatistics is working", () {
      late List<Selecao> selections;

      setUpAll(() {
        selections = List.generate(2, (_) => FakeFactory.generateSelecao());
      });

      test("Returns an int when  no errors occur", () async {
        when(() => datasource.updateSelectionsStatistics(any()))
            .thenAnswer((_) async => 0);

        var result = await repository.updateSelectionsStatistics(selections);
        expect(result.isRight(), isTrue);
        expect(result.fold(id, id), isA<int>());
        expect(result.fold(id, id), equals(0));
      });

      test("Returns a Failure when an error occur", () async {
        when(() => datasource.updateSelectionsStatistics(any()))
            .thenThrow(NoSelectionsFound(message));

        var result = await repository.updateSelectionsStatistics(selections);
        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold((l) => l.toString(), id), equals(message));
      });
    });
  });
}
