import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/selecao_factory.dart';
import 'package:futebol/src/data/usecases/get_selecoes_by_group_impl.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/errors/errors.dart';
import 'package:mockito/mockito.dart';
import 'repository.mocks.dart';

void main() {
  final repository = MockRepositoryMock();
  final usecase = GetSelecoesByGroup(repository);
  group("Usecase GetSelecoesByGroup is working", () {
    group("Usecase Validations are ok", () {
      when(repository.getSelecoesByGroup(any)).thenAnswer((_) async => Right(
          List.generate(
              4, (index) => FakeFactory.generateSelecaoWithGroup('A'))));

      test("Returns a List of Selecao when no errors occur", () async {
        final result = await usecase("A");

        expect(result.fold(id, id), isA<List<Selecao>>());
      });
      test("In the Selecao List, all group fields are equal", () async {
        final result = await usecase("A");

        bool allElementsGroupAreEqual = true;

        result.fold(id, (r) {
          for (var element in r) {
            if (element.grupo != 'A') {
              allElementsGroupAreEqual = false;
              break;
            }
          }
        });

        expect(result.fold(id, id), isA<List<Selecao>>());
        expect(allElementsGroupAreEqual, isTrue);
      });

      test("Returns an Error when giving a whitespace", () async {
        var result = await usecase(" ");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<InvalidSearchText>());

        result = await usecase("");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<InvalidSearchText>());
      });

      test("Returns an error when giving more than one letter", () async {
        final result = await usecase("ab");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<InvalidSearchText>());
      });
    });

    test("Returns an Error when error occur on repository", () async {
      final error = DataSourceError();
      when(repository.getSelecoesByGroup(any))
          .thenAnswer((_) async => Left(error));

      var result = await usecase("a");

      expect(result.fold(id, id), isA<Failure>());
      expect(result.fold(id, id), isA<DataSourceError>());
      expect(result.fold(id, id), equals(error));
    });
  });
}
