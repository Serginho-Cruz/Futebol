import 'package:dartz/dartz.dart';

import '../../../errors/errors_classes/errors_classes.dart';
import '../../entities/Match/match_entity.dart';

abstract class IGetMatchsByType {
  Future<Either<Failure, List<SoccerMatch>>> call(int type);
}
