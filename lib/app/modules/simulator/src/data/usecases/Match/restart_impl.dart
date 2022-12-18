import 'package:dartz/dartz.dart';
import 'package:futebol/app/modules/simulator/src/data/repository/match_repository_interface.dart';
import 'package:futebol/app/modules/simulator/src/domain/usecases/Match/restart_interface.dart';
import 'package:futebol/app/modules/simulator/src/errors/errors_classes/errors_classes.dart';

class RestartUC implements IRestart {
  final IMatchRepository repository;

  RestartUC(this.repository);
  @override
  Future<Either<Failure, void>> call() async {
    return await repository.restart();
  }
}
