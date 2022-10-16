import '../../repository/match_repository_interface.dart';
import '../../../domain/entities/Match/match_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/usecases/Match/get_matchs_by_type_interface.dart';
import '../../../errors/errors_classes/errors_classes.dart';

class GetMatchsByTypeUC implements IGetMatchsByType {
  final IMatchRepository repository;

  GetMatchsByTypeUC(this.repository);
  @override
  Future<Either<Failure, List<SoccerMatch>>> call(int type) async =>
      await repository.getMatchsByType(type);
}
