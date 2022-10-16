import 'package:dartz/dartz.dart';
import '../../data/repository/match_repository_interface.dart';
import '../datasource/datasource_interface.dart';

import '../../domain/entities/Match/match_entity.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../../errors/errors_messages_classes/errors_messages.dart';

class MatchRepository implements IMatchRepository {
  final IDataSource datasource;

  MatchRepository(this.datasource);
  @override
  Future<Either<Failure, List<SoccerMatch>>> getMatchsByGroup(
      String group) async {
    try {
      var matchs = await datasource.getMatchsByGroup(group);
      return Right(matchs);
    } on DataSourceError catch (e) {
      return Left(e);
    } on NoMatchsFound catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError(Messages.genericError));
    }
  }

  @override
  Future<Either<Failure, List<SoccerMatch>>> getMatchsByType(int type) async {
    try {
      var matchs = await datasource.getMatchsByType(type);
      return Right(matchs);
    } on DataSourceError catch (e) {
      return Left(e);
    } on NoMatchsFound catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError(Messages.genericError));
    }
  }

  @override
  Future<Either<Failure, SoccerMatch>> getMatchById(int id) async {
    try {
      var result = await datasource.getMatchById(id);
      return Right(result);
    } on NoMatchFound catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError(Messages.genericError));
    }
  }

  @override
  Future<Either<Failure, List<int>>> changeScoreboard(SoccerMatch match) async {
    try {
      var result = await datasource.changeScoreboard(match);
      return Right(result);
    } on NoMatchFound catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError(Messages.genericError));
    }
  }
}