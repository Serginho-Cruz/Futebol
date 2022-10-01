import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import '../../errors/errors_classes/errors_classes.dart';

abstract class ISelectionRepository {
  Future<Either<Failure, List<Selecao>>> getAllSelections();
  Future<Either<Failure, List<Selecao>>> getSelectionsByGroup(String group);
  Future<Either<Failure, Selecao>> getSelection(int id);
  Future<Either<Failure, List<Selecao>>> getSelectionsByIds(List<int> ids);
  Future<Either<Failure, int>> updateSelectionsStatistics(
      List<Selecao> selections);
}
