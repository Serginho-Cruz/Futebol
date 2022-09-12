import 'package:futebol/src/domain/entities/Match/match_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/usecases/getMatchsByType/get_matchs_by_type_interface.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

import '../repository/match_repository_interface.dart';

class GetMatchsByTypeUC implements IGetMatchsByType {
  final ISoccerMatchRepository repository;

  GetMatchsByTypeUC(this.repository);
  @override
  Future<Either<Failure, List<SoccerMatch>>> call(int type) async =>
      await repository.getMatchsByType(type);
}
