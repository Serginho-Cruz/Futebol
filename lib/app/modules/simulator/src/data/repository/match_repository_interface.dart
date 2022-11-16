import 'package:dartz/dartz.dart';

import '../../domain/entities/Match/match_entity.dart';
import '../../domain/entities/Selection/selection_entity.dart';
import '../../errors/errors_classes/errors_classes.dart';

abstract class IMatchRepository {
  Future<Either<Failure, List<SoccerMatch>>> getMatchsByType(int type);
  Future<Either<Failure, List<SoccerMatch>>> getMatchsByGroup(String group);
  Future<Either<Failure, SoccerMatch>> getMatchById(int id);
  Future<Either<Failure, List<int?>>> changeScoreboard(SoccerMatch newMatch);
  Future<Either<Failure, void>> updateRound16Matchs(
    int idMatch1,
    int idMatch2,
    List<Selecao> selections,
  );
}
