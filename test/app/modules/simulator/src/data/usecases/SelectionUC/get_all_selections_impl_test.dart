import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/app/modules/simulator/src/data/usecases/Selection/get_all_selections_impl.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/app/modules/simulator/src/errors/errors_classes/errors_classes.dart';
import 'package:mocktail/mocktail.dart';
import 'package:futebol/app/modules/simulator/helpers/selection_factory.dart';

import '../classes_mocks.dart';

void main() {
  final repository = SelectionRepositoryMock();
  final usecase = GetAllSelectionsUC(repository);

  group("Usecase GetAllSelecoes is working rightly", () {
    test("Returns an Error when repository fails", () async {
      when(() => repository.getAllSelections())
          .thenAnswer((any) async => Left(DataSourceError("")));

      var result = await usecase();

      expect(result.fold(id, id), isA<Failure>());
      expect(result.fold(id, id), isA<DataSourceError>());
    });
    test("Returns a List of Selecoes if no errors occur", () async {
      when(() => repository.getAllSelections()).thenAnswer((any) async =>
          Right(List.generate(10, (index) => FakeFactory.generateSelecao())));

      var result = await usecase();

      expect(result.fold(id, id), isA<List>());
      expect(result.fold(id, id), isA<List<Selecao>>());
    });
  });
}
