import 'package:dartz/dartz.dart';

import '../../../errors/errors_classes/errors_classes.dart';

abstract class IUpdateFinals {
  Future<Either<Failure, void>> call({
    required int winnerId,
    required int loserId,
    required int idMatch,
  });
}
