import 'package:dartz/dartz.dart';
import '../../repository/match_repository_interface.dart';
import '../../../domain/entities/Match/match_entity.dart';
import '../../../errors/errors_classes/errors_classes.dart';

import '../../../domain/usecases/Match/get_matchs_by_group.dart';

class GetMatchsByGroupUC implements IGetMatchsByGroup {
  final IMatchRepository repository;

  GetMatchsByGroupUC(this.repository);

  @override
  Future<Either<Failure, List<SoccerMatch>>> call(String group) async =>
      await repository.getMatchsByGroup(group);
}
