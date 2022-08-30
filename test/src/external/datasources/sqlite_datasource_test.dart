import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/fake_db.dart';
import 'package:futebol/helpers/selecao_factory.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/domain/selecao_mapper.dart';
import 'package:futebol/src/errors/errors.dart';
import 'package:futebol/src/external/datasources/sqlite_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'datasource.mocks.dart';

@GenerateMocks([DBMock])
class DBMock extends Mock implements FakeDB {}

void main() {
  final db = MockDBMock();
  final db2 = FakeDB(numSelecoes: 10);
  SQLitedatasource datasource;
  group("SQLite datasource is working rightly", () {
    group("Method getAllSelecoes is working", () {
      test("Returns a List of Selecoes when no errors occur", () async {
        datasource = SQLitedatasource(db);

        when(db.getAll()).thenAnswer((_) async => List.generate(
              10,
              (_) => SelecaoMapper.toMap(FakeFactory.generateSelecao()),
            ));

        var result = await datasource.getAllSelecoes();

        expect(result.fold(id, id), isA<List>());
        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, (r) => r.length), equals(10));
      });

      group("Returns an error when DB throws that", () {
        datasource = SQLitedatasource(db);

        test("Must return an EmptyList when db throws that", () async {
          when(db.getAll()).thenThrow(EmptyList());

          var result = await datasource.getAllSelecoes();

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<EmptyList>());
          expect(result.fold(((l) => l.toString()), id), isA<String>());
        });

        test("Must return a DataSourceError when db throws that", () async {
          when(db.getAll()).thenThrow(DataSourceError());

          var result = await datasource.getAllSelecoes();

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<DataSourceError>());
          expect(result.fold(((l) => l.toString()), id), isA<String>());
        });
        test("Must return a DataSourceError when db throws that", () async {
          when(db.getAll()).thenThrow(Exception());

          var result = await datasource.getAllSelecoes();

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<DataSourceError>());
          expect(result.fold(((l) => l.toString()), id), isA<String>());
        });
      });
      test("Returns an Error if has no selecoes", () async {
        datasource = SQLitedatasource(FakeDB(numSelecoes: 0));

        var result = await datasource.getAllSelecoes();

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<EmptyList>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });
    });

    group("Method getSelecoesByGroup is working", () {
      test("Returns a list of selecoes when no errors occur", () async {
        datasource = SQLitedatasource(db);
        String group = 'A';
        when(db.getByGroup(any)).thenAnswer((_) async => List.generate(
              10,
              (_) => SelecaoMapper.toMap(
                  FakeFactory.generateSelecaoWithGroup(group)),
              growable: false,
            ));

        var result = await datasource.getSelecaoByGroup(group);

        expect(result.fold(id, id), isA<List>());
        expect(result.fold(id, id), isA<List<Selecao>>());
      });

      group("Return error in all cases, when db throws", () {
        datasource = SQLitedatasource(db);
        String group = 'B';

        test("Returns an EmptyList when db throws", () async {
          when(db.getByGroup(any)).thenThrow(EmptyList());

          var result = await datasource.getSelecaoByGroup(group);

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<EmptyList>());
          expect(result.fold((l) => l.toString(), id), isA<String>());
        });
        test("Returns an DataSourceError when db throws", () async {
          when(db.getByGroup(any)).thenThrow(DataSourceError());

          var result = await datasource.getSelecaoByGroup(group);

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<DataSourceError>());
          expect(result.fold((l) => l.toString(), id), isA<String>());
        });
        test("Returns an DataSourceError when db throws Exception", () async {
          when(db.getByGroup(any)).thenThrow(Exception());

          var result = await datasource.getSelecaoByGroup(group);

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<DataSourceError>());
          expect(result.fold((l) => l.toString(), id), isA<String>());
        });
      });

      test("Returns an EmptyList when group is not found", () async {
        datasource = SQLitedatasource(db2);
        when(db.getByGroup(any)).thenThrow(EmptyList());

        var result = await datasource.getSelecaoByGroup('pp');

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<EmptyList>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });
      test("Returns an Error if has no selecoes", () async {
        datasource = SQLitedatasource(FakeDB(numSelecoes: 0));

        var result = await datasource.getAllSelecoes();

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<EmptyList>());
        expect(result.fold((l) => l.toString(), id), isA<String>());
      });
    });
    group("Method getSelecao is working", () {
      test("Returns a selecao when no errors occur", () async {
        datasource = SQLitedatasource(db);
        when(db.getSelecaoById(any)).thenAnswer(
            (_) async => SelecaoMapper.toMap(FakeFactory.generateSelecao()));

        var result = await datasource.getSelecaoById(2);

        expect(result.fold(id, id), isA<Selecao>());
      });

      group("Return error in all cases, when db throws", () {
        datasource = SQLitedatasource(db);
        int number = 1;

        test("Returns an EmptyList when db throws", () async {
          when(db.getSelecaoById(any)).thenThrow(EmptyList());

          var result = await datasource.getSelecaoById(number);

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<EmptyList>());
          expect(result.fold((l) => l.toString(), id), isA<String>());
        });
        test("Returns an DataSourceError when db throws", () async {
          when(db.getSelecaoById(any)).thenThrow(DataSourceError());

          var result = await datasource.getSelecaoById(number);

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<DataSourceError>());
          expect(result.fold((l) => l.toString(), id), isA<String>());
        });
        test("Returns an DataSourceError when db throws Exception", () async {
          when(db.getByGroup(any)).thenThrow(Exception());

          var result = await datasource.getSelecaoById(number);

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<DataSourceError>());
          expect(result.fold((l) => l.toString(), id), isA<String>());
        });
        test("Returns an SelecaoError when selecao is not found", () async {
          when(db.getSelecaoById(any)).thenThrow(SelecaoError(""));

          var result = await datasource.getSelecaoById(number);

          expect(result.fold(id, id), isA<Failure>());
          expect(result.fold(id, id), isA<SelecaoError>());
          expect(result.fold((l) => l.toString(), id), isA<String>());
        });
      });
    });
  });
}
