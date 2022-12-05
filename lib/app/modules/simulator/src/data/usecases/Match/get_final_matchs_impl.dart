import '../../../errors/errors_classes/errors_classes.dart';

import '../../../domain/entities/Match/match_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../domain/usecases/Match/get_final_matchs_interface.dart';
import '../../repository/match_repository_interface.dart';

class GetFinalMatchsUC implements IGetFinalMatchs {
  final IMatchRepository repository;

  GetFinalMatchsUC(this.repository);

  @override
  Future<Either<Failure, List<SoccerMatch>>> call() async =>
      await repository.getFinalMatchs();
}
