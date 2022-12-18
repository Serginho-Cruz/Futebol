import 'package:dartz/dartz.dart';

import '../../../errors/errors_classes/errors_classes.dart';

abstract class IRestart {
  Future<Either<Failure, void>> call();
}
