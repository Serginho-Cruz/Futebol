import 'package:dartz/dartz.dart';

import '../../domain/selecao_entity.dart';
import '../../errors/errors.dart';

abstract class IDataSource {
  Future<Either<Failure, List<Selecao>>> getAllSelecoes();
  Future<Either<Failure, List<Selecao>>> getSelecaoByGroup(String group);
  Future<Either<Failure, Selecao>> getSelecaoById(int id);
}
