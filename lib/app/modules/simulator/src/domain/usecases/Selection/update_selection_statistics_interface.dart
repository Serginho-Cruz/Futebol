import 'package:dartz/dartz.dart';

import '../../../errors/errors_classes/errors_classes.dart';
import '../../entities/Selection/selection_entity.dart';

abstract class IUpdateSelectionStatistics {
  Future<Either<Failure, List<Selecao>>> call({
    required int selectionId1,
    required int selectionId2,
    required List<int> newScores,
    required List<int?> oldScores,
    required String group,
  });
}
