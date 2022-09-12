import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/helpers/selection_factory.dart';
import 'package:futebol/src/data/repository/repository_interface.dart';
import 'package:futebol/src/data/usecases/get_all_selections_impl.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'selection_repository.mocks.dart';

@GenerateMocks([RepositoryMock])
class RepositoryMock extends Mock implements SelectionRepository {}

void main() {
  final repository = MockRepositoryMock();
  final usecase = GetAllSelectionsUC(repository);

  group("Usecase GetAllSelecoes is working rightly", () {
    test("Returns an Error when repository fails", () async {
      when(repository.getAllSelections())
          .thenAnswer((any) async => Left(DataSourceError("")));

      var result = await usecase();

      expect(result.fold(id, id), isA<Failure>());
      expect(result.fold(id, id), isA<DataSourceError>());
    });
    test("Returns a List of Selecoes if no errors occur", () async {
      when(repository.getAllSelections()).thenAnswer((any) async =>
          Right(List.generate(10, (index) => FakeFactory.generateSelecao())));

      var result = await usecase();

      expect(result.fold(id, id), isA<List>());
      expect(result.fold(id, id), isA<List<Selecao>>());
    });
  });
}
