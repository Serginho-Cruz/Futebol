import 'package:dartz/dartz.dart';
import '../../repository/match_repository_interface.dart';
import '../../../domain/entities/Selection/selection_entity.dart';
import '../../../domain/usecases/Selection/update_selection_statistics_interface.dart';
import '../../../errors/errors_classes/errors_classes.dart';

import '../../../domain/entities/Match/match_entity.dart';
import '../../../domain/usecases/Match/change_scoreboard_interface.dart';

class ChangeScoreboardUC implements IChangeScoreboard {
  final IMatchRepository repository;

  ChangeScoreboardUC({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<int>>> call({
    required int score1,
    required int score2,
    required SoccerMatch match,
    List<int>? extratimeScores,
    List<int>? penaltyScores,
  }) async {
    var result = await repository.changeScoreboard(
      SoccerMatch(
        id: match.id,
        idSelection1: match.idSelection1,
        idSelection2: match.idSelection2,
        local: match.local,
        date: match.date,
        hour: match.hour,
        type: match.type,
        score1: score1,
        score2: score2,
        extratimeScore1: extratimeScores?.first,
        extraTimeScore2: extratimeScores?[1],
        penaltyScore1: penaltyScores?.first,
        penaltyScore2: penaltyScores?[1],
      ),
    );
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
