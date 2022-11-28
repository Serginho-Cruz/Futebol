import 'package:dartz/dartz.dart';

import '../../../errors/errors_classes/errors_classes.dart';
import '../../entities/Selection/selection_entity.dart';

abstract class IGetAllSelections {
  Future<Either<Failure, List<Selecao>>> call();
}
