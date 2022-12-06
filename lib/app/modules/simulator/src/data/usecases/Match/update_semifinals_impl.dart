import '../../repository/match_repository_interface.dart';
import '../../../errors/errors_classes/errors_classes.dart';

import 'package:dartz/dartz.dart';

import '../../../domain/usecases/Match/update_semifinals_interface.dart';

class UpdateSemifinalsUC implements IUpdateSemifinals {
  final IMatchRepository repository;

  UpdateSemifinalsUC(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required int matchId,
    required int winnerId,
  }) async {
    int idDestiny = 0;
    bool isId1;

    int number = matchId > 58 ? 2 : 1;
    if (matchId.isOdd) {
      idDestiny = matchId + 1 + (60 - (matchId + 1)) + number;
      isId1 = true;
    } else {
      idDestiny = matchId + (60 - matchId) + number;
      isId1 = false;
    }

    return await repository.updateNextPhase(
      idDestiny: idDestiny,
      idSelection: winnerId,
      isId1: isId1,
    );
  }
}
