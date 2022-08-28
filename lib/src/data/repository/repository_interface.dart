import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/selecao_entity.dart';

import '../../errors/errors.dart';

abstract class IRepository {
  Either<Failure, List<Selecao>> getAllSelecoes();
  Either<Failure, List<Selecao>> getSelecoesByGroup();
}
