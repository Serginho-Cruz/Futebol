import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/entities/Match/match_entity.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

abstract class IGetMatchsByGroup {
  Future<Either<Failure, List<SoccerMatch>>> call(String group);
}
