import 'package:dartz/dartz.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

abstract class IChangeKnockoutScoreboard {
  Future<Either<Failure, int>> call({
    required int matchId,
    required List<int> newScores,
    List<int>? penaltyScores,
    List<int>? extraTimeScores,
  });
}
