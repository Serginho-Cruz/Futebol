import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/entities/selecao_entity.dart';

import '../../../errors/errors_classes/errors_classes.dart';

abstract class IGetSelectionsByGroup {
  Future<Either<Failure, List<Selecao>>> call(String group);
}
