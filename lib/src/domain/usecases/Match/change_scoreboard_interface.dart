import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

abstract class IChangeGroupScoreboard {
  Future<Either<Failure, List<Selecao>>> call({
    required int selectionId1,
    required int selectionId2,
    required int score1,
    required int score2,
    required int matchId,
  });
}
