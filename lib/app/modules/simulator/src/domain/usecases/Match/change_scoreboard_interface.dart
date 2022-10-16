import 'package:dartz/dartz.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Match/match_entity.dart';
import '../../../errors/errors_classes/errors_classes.dart';

abstract class IChangeScoreboard {
  Future<Either<Failure, List<int>>> call({
    required int score1,
    required int score2,
    required SoccerMatch match,
    List<int>? extratimeScores,
    List<int>? penaltyScores,
  });
}
