import 'package:dartz/dartz.dart';

import '../../../errors/errors_classes/errors_classes.dart';

abstract class IUpdateQuarters {
  Future<Either<Failure, void>> call({
    required int matchId,
    required int winnerId,
  });
}
