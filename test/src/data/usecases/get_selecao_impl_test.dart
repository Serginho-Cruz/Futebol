import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/src/data/usecases/get_selecao_impl.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/errors/errors.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/selecao_factory.dart';
import 'repository.mocks.dart';

void main() {
  final repository = MockRepositoryMock();
  final usecase = GetSelecao(repository);
  group("GetSelecao Usecase is working", () {
    when(repository.getSelecao(any))
        .thenAnswer((_) async => Right(FakeFactory.generateSelecao()));
    test("Returns an error when given id is zero or negative", () async {
      var result = await usecase(0);

      expect(result.fold(id, id), isA<Failure>());
      expect(result.fold(id, id), isA<InvalidId>());

      result = await usecase(-1);

      expect(result.fold(id, id), isA<Failure>());
      expect(result.fold(id, id), isA<InvalidId>());
    });

    test("Returns a Selecao when id is positive", () async {
      var result = await usecase(2);

      expect(result.fold(id, id), isA<Selecao>());

      result = await usecase(50);

      expect(result.fold(id, id), isA<Selecao>());
    });
  });
}
