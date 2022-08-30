import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/selecao_entity.dart';

import '../../errors/errors.dart';

abstract class IRepository {
  Future<Either<Failure, List<Selecao>>> getAllSelecoes();
  Future<Either<Failure, List<Selecao>>> getSelecoesByGroup(String group);
  Future<Either<Failure, Selecao>> getSelecao(int id);
}
