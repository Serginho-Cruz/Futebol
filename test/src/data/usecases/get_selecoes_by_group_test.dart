import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/src/data/repository/repository_interface.dart';
import 'package:futebol/src/data/usecases/get_selecoes_by_group_impl.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/errors/errors.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/selecao_factory.dart';
import 'repository.mocks.dart';

class RepositoryMock extends Mock implements IRepository {}

void main() {
  final repository = MockRepositoryMock();
  final usecase = GetSelecoesByGroup(repository);
  group("Usecase GetSelecoesByGroup is working", () {
    group("Usecase Validations are ok", () {
      final list = List.generate(4, (index) => FakeFactory.generateSelecoes());
      when(repository.getSelecoesByGroup(""))
          .thenAnswer((_) async => Right(list));

      test("Returns a List of Selecao when no errors occur", () async {
        final result = await usecase("A");

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(result.fold(id, id), equals(list));
      });

      test("Returns an Error when giving a whitespace", () async {
        var result = await usecase(" ");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<InvalidGroupText>());

        result = await usecase("");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<InvalidGroupText>());
      });

      test("Returns an error when giving more than one letter", () async {
        final result = await usecase("ab");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<InvalidGroupText>());
      });
    });

    test("Returns an Error when error occur on repository", () async {
      final error = DataSourceError();
      when(repository.getSelecoesByGroup(""))
          .thenAnswer((_) async => Left(error));

      var result = await usecase("a");

      expect(result.fold(id, id), isA<Failure>());
      expect(result.fold(id, id), isA<DataSourceError>());
      expect(result.fold(id, id), equals(error));
    });
  });
}
