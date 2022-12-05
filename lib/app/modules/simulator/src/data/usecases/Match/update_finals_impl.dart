import '../../repository/match_repository_interface.dart';
import '../../../errors/errors_classes/errors_classes.dart';

import 'package:dartz/dartz.dart';

import '../../../domain/usecases/Match/update_finals_interface.dart';

class UpdateFinalsUC implements IUpdateFinals {
  final IMatchRepository repository;

  UpdateFinalsUC(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required int winnerId,
    required int loserId,
    required int idMatch,
  }) async {
    bool isId1;
    if (idMatch.isOdd) {
      isId1 = true;
    } else {
      isId1 = false;
    }

    var result = await repository.updateNextPhase(
      idDestiny: 64,
      idSelection: winnerId,
      isId1: isId1,
    );

    if (result.isLeft()) {
      return result;
    }

    return await repository.updateNextPhase(
      idDestiny: 63,
      idSelection: loserId,
      isId1: isId1,
    );
  }
}
