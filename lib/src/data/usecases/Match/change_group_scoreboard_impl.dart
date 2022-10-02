import 'package:dartz/dartz.dart';
import 'package:futebol/src/data/repository/match_repository_interface.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/domain/usecases/Selection/update_selection_statistics_interface.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

import '../../../domain/entities/Match/match_entity.dart';
import '../../../domain/usecases/Match/change_scoreboard_interface.dart';

class ChangeGroupScoreboardUC implements IChangeGroupScoreboard {
  final IMatchRepository repository;
  final IUpdateSelectionStatistics updateSelections;

  ChangeGroupScoreboardUC({
    required this.repository,
    required this.updateSelections,
  });

  @override
  Future<Either<Failure, List<Selecao>>> call({
    required int selectionId1,
    required int selectionId2,
    required int score1,
    required int score2,
    required int matchId,
  }) async {
    var result = await repository.getMatchById(matchId);

    return result.fold((l) => Left(l), (match) async {
      var result = await updateSelections(
        newScores: [score1, score2],
        oldScores: [match.score1, match.score2],
        selectionId1: selectionId1,
        selectionId2: selectionId2,
      );

      return result.fold((l) => Left(l), (selections) async {
        var result = await repository.changeScoreboard(
          SoccerMatch(
              id: matchId,
              idSelection1: selectionId1,
              idSelection2: selectionId2,
              local: match.local,
              date: match.date,
              hour: match.hour,
              type: match.type,
              score1: score1,
              score2: score2),
        );

        return result.fold((l) => Left(l), (r) => Right(selections));
      });
    });
  }
}
