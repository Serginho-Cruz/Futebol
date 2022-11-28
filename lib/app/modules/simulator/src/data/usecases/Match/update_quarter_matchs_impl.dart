import 'package:dartz/dartz.dart';
import '../../../domain/usecases/Match/update_quarter_matchs_interface.dart';
import '../../../errors/errors_classes/errors_classes.dart';

import '../../repository/match_repository_interface.dart';

class UpdateQuarterMatchsUC implements IUpdateQuarterMatchs {
  final IMatchRepository repository;

  UpdateQuarterMatchsUC(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required int matchId,
    required int winnerId,
  }) async {
    bool isId1;
    int idDestiny;

    if (matchId.isOdd) {
      idDestiny = matchId + 1 + 8 - (matchId + 1 - 48) ~/ 2;
      isId1 = true;
    } else {
      idDestiny = matchId + 8 - (matchId - 48) ~/ 2;
      isId1 = false;
    }

    return await repository.updateQuarterMatchs(
      idDestiny: idDestiny,
      idSelection: winnerId,
      isId1: isId1,
    );
  }
}
