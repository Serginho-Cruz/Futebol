import 'package:futebol/src/data/repository/match_repository_interface.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

import 'package:dartz/dartz.dart';

import '../../../domain/entities/Match/match_entity.dart';
import '../../../domain/usecases/Match/change_knockout_scoreboard_interface.dart';

class ChangeKnockoutScoreboard implements IChangeKnockoutScoreboard {
  final IMatchRepository repository;

  ChangeKnockoutScoreboard(this.repository);
  @override
  Future<Either<Failure, int>> call({
    required int matchId,
    required List<int> newScores,
    List<int>? penaltyScores,
    List<int>? extraTimeScores,
  }) async {
    var result = await repository.getMatchById(matchId);

    return result.fold((l) => Left(l), (match) async {
      var result = await repository.changeScoreboard(
        SoccerMatch(
          id: matchId,
          idSelection1: match.idSelection1,
          idSelection2: match.idSelection2,
          local: match.local,
          date: match.date,
          hour: match.hour,
          type: match.type,
          score1: newScores.first,
          score2: newScores[1],
          group: match.group,
          penaltyScore1: match.penaltyScore1,
          penaltyScore2: match.penaltyScore2,
          extratimeScore1: extraTimeScores?.first,
          extraTimeScore2: extraTimeScores?[1],
        ),
      );

      return result.fold((l) => Left(l), (r) => Right(r));
    });
  }
}
