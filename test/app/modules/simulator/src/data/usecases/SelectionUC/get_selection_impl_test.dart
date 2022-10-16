import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futebol/app/modules/simulator/helpers/selection_factory.dart';
import 'package:futebol/app/modules/simulator/src/data/usecases/Selection/get_selection_impl.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/app/modules/simulator/src/errors/errors_classes/errors_classes.dart';
import 'package:mocktail/mocktail.dart';
import '../classes_mocks.dart';

void main() {
  final repository = SelectionRepositoryMock();
  final usecase = GetSelectionUC(repository);
  group("GetSelecao Usecase is working", () {
    when(() => repository.getSelection(any()))
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
