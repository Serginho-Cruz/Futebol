import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/errors/errors.dart';
import 'package:futebol/src/infra/datasource/datasource_interface.dart';
import 'package:futebol/src/infra/repositories/repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../../../helpers/selecao_factory.dart';
import 'datasource.mocks.dart';

@GenerateMocks([DataSourceMock])
class DataSourceMock extends Mock implements IDataSource {}

void main() {
  final datasource = MockDataSourceMock();
  final repository = Repository(datasource: datasource);

  group("Repository is working rightly", () {
    group("Method getAllSelecoes is working addequately", () {
      test("Returns an EmptyList when datasource throw that", () async {
        when(datasource.getAllSelecoes()).thenThrow(EmptyList("Empty List"));

        var result = await repository.getAllSelecoes();

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<EmptyList>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });

      test("Returns a List of Selecao when datasource answer that", () async {
        when(datasource.getAllSelecoes()).thenAnswer((_) async =>
            List.generate(10, (index) => FakeFactory.generateSelecao()));

        var result = await repository.getAllSelecoes();

        expect(result.fold(id, id), isA<List>());
        expect(result.fold(id, id), isA<List<Selecao>>());
      });

      test("Returns a DataSourceError when datasource throw that", () async {
        when(datasource.getAllSelecoes()).thenThrow(DataSourceError());

        var result = await repository.getAllSelecoes();

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });

      test("Returns a DataSourceError when a Exception is throwed", () async {
        when(datasource.getAllSelecoes()).thenThrow(Exception());

        var result = await repository.getAllSelecoes();

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });
    });

    group("Method getSelecoesByGroup is working adequatelly", () {
      test("Returns an EmptyList when datasource throws that", () async {
        when(datasource.getSelecaoByGroup(any)).thenThrow(EmptyList());

        var result = await repository.getSelecoesByGroup("A");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<EmptyList>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });

      test("Returns a DataSourceError when datasource throws that", () async {
        when(datasource.getSelecaoByGroup(any)).thenThrow(DataSourceError());

        var result = await repository.getSelecoesByGroup('A');

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });

      test("Returns a DataSourceError when an Exception is throwed", () async {
        when(datasource.getSelecaoByGroup(any)).thenThrow(Exception());

        var result = await repository.getSelecoesByGroup('A');

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });
    });
    group("Method getSelecao is working adequatelly", () {
      test("Returns a SelecaoError when datasource throws that", () async {
        when(datasource.getSelecaoById(any))
            .thenThrow(SelecaoError("Selecao Don't Exist"));

        var result = await repository.getSelecao(10);

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<SelecaoError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });

      test("Returns a DataSourceError when datasource throws that", () async {
        when(datasource.getSelecaoById(any)).thenThrow(DataSourceError());

        var result = await repository.getSelecao(5);

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });

      test("Returns a DataSourceError when an Exception is throwed", () async {
        when(datasource.getSelecaoById(any)).thenThrow(Exception());

        var result = await repository.getSelecao(2);

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });
    });
  });
}
