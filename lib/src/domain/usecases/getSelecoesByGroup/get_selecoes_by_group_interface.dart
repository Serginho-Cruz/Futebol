import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/selecao_entity.dart';

import '../../../errors/errors.dart';

abstract class IGetSelecoesByGroup {
  Future<Either<Failure, List<Selecao>>> call(String group);
}
