import 'package:dartz/dartz.dart';

import '../../../errors/errors_classes/errors_classes.dart';
import '../../entities/Selection/selection_entity.dart';

abstract class IUpdateRound16Matchs {
  Future<Either<Failure, void>> call({
    required List<Selecao> winners,
    required String group,
  });
}
