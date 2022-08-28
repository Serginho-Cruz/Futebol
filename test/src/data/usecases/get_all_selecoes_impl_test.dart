import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/src/data/repository/repository_interface.dart';
import 'package:futebol/src/data/usecases/get_all_selecoes_impl.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'repository.mocks.dart';

import '../../../../helpers/selecao_factory.dart';

@GenerateMocks([RepositoryMock])
class RepositoryMock extends Mock implements IRepository {}

void main() {
  final repository = MockRepositoryMock();
  final usecase = GetAllSelecoes(repository);

  group("Usecase GetAllSelecoes is working rightly", () {
    test("Returns a List of Selecoes if no errors occur", () async {
      final list = List.generate(10, (index) => FakeFactory.generateSelecoes());
      when(repository.getAllSelecoes()).thenAnswer((any) async => Right(list));

      var result = await usecase();

      expect(result.fold(id, id), isA<List>());
      expect(result.fold(id, id), isA<List<Selecao>>());
      expect(result.fold(id, id), equals(list));
    });
  });
}
