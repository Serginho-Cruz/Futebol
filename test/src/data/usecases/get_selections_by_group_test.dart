import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/selecao_factory.dart';
import 'package:futebol/src/data/usecases/get_selections_by_group_impl.dart';
import 'package:futebol/src/domain/entities/selecao_entity.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';
import 'package:mockito/mockito.dart';
import 'repository.mocks.dart';

void main() {
  final repository = MockRepositoryMock();
  final usecase = GetSelectionsByGroupUC(repository);
  group("Usecase GetSelecoesByGroup is working", () {
    group("Usecase Validations are ok", () {
      when(repository.getSelectionsByGroup(any)).thenAnswer((_) async => Right(
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
      test("Returns an Error when error occur on repository", () async {
        final error = DataSourceError("");
        when(repository.getSelectionsByGroup(any))
            .thenAnswer((_) async => Left(error));

        var result = await usecase("a");

        expect(result.fold(id, id), isA<Failure>());
        expect(result.fold(id, id), isA<DataSourceError>());
        expect(result.fold(id, id), equals(error));
      });
    });
  });
}
