import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/selecao_factory.dart';
import 'package:futebol/src/domain/entities/selecao_entity.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';
import 'package:futebol/src/infra/datasource/datasource_interface.dart';
import 'package:futebol/src/infra/repositories/repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'datasource.mocks.dart';

@GenerateMocks([DataSourceMock])
class DataSourceMock extends Mock implements IDataSource {}

void main() {
  final datasource = MockDataSourceMock();
  final repository = Repository(datasource: datasource);

  group("Repository is working rightly", () {
    group("Method getAllSelections is working addequately", () {
      test("Returns an SelectionError when datasource throw that", () async {
        when(datasource.getAllSelections())
            .thenAnswer((_) async => throw SelectionError(""));

        var result = await repository.getAllSelections();

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<SelectionError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });

      test("Returns a List of Selecao when datasource answer that", () async {
        when(datasource.getAllSelections()).thenAnswer((_) async =>
            List.generate(10, (index) => FakeFactory.generateSelecao()));

        var result = await repository.getAllSelections();

        expect(result.fold(id, id), isA<List>());
        expect(result.fold(id, id), isA<List<Selecao>>());
      });

      test("Returns a DataSourceError when datasource throw that", () async {
        when(datasource.getAllSelections())
            .thenAnswer((_) async => throw DataSourceError(""));

        var result = await repository.getAllSelections();

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });
    });

    group("Method getSelectionsByGroup is working adequatelly", () {
      test("Returns an SelectionError when datasource throws that", () async {
        when(datasource.getSelectionsByGroup(any))
            .thenAnswer((_) async => throw SelectionError(""));

        var result = await repository.getSelectionsByGroup("A");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<SelectionError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });

      test("Returns a DataSourceError when datasource throws that", () async {
        when(datasource.getSelectionsByGroup(any))
            .thenAnswer((_) async => throw DataSourceError(""));

        var result = await repository.getSelectionsByGroup('A');

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });
    });
    group("Method getSelecao is working adequatelly", () {
      test("Returns a Selecao when no errors occur", () async {
        when(datasource.getSelectionById(any))
            .thenAnswer((_) async => FakeFactory.generateSelecao());

        var result = await repository.getSelection(10);

        expect(result.fold(id, id), isA<Selecao>());
      });

      test("Returns a DataSourceError when datasource throws that", () async {
        when(datasource.getSelectionById(any))
            .thenAnswer((_) async => throw DataSourceError(""));

        var result = await repository.getSelection(5);

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });
    });
  });
}
