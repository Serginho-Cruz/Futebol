import 'package:dartz/dartz.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

import '../../domain/entities/Match/match_entity.dart';

abstract class ISoccerMatchRepository {
  Future<Either<Failure, List<SoccerMatch>>> getMatchsByType(int type);
  Future<Either<Failure, List<SoccerMatch>>> getMatchsByGroup(String group);
}
