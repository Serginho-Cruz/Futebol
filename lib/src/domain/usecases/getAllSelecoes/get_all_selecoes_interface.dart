import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/selecao_entity.dart';

import '../../../errors/errors.dart';

abstract class IGetAllSelecoes {
  Future<Either<Failure, List<Selecao>>> call();
}
