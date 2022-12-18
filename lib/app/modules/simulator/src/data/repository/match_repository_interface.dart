import 'package:dartz/dartz.dart';

import '../../domain/entities/Match/match_entity.dart';
import '../../domain/entities/Selection/selection_entity.dart';
import '../../errors/errors_classes/errors_classes.dart';

abstract class IMatchRepository {
  Future<Either<Failure, List<SoccerMatch>>> getMatchsByType(int type);
  Future<Either<Failure, List<SoccerMatch>>> getMatchsByGroup(String group);
  Future<Either<Failure, SoccerMatch>> getMatchById(int id);
  Future<Either<Failure, List<int?>>> changeScoreboard(SoccerMatch newMatch);
  Future<Either<Failure, void>> updateRound16({
    required int idMatch1,
    required int idMatch2,
    required List<Selecao> selections,
  });

  Future<Either<Failure, void>> updateNextPhase({
    required int idDestiny,
    required int idSelection,
    required bool isId1,
  });
  Future<Either<Failure, List<SoccerMatch>>> getFinalMatchs();
  Future<Either<Failure, void>> restart();
}
