import '../../../errors/errors_classes/errors_classes.dart';

import '../../../domain/entities/Selection/selection_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../domain/usecases/Match/update_round16_matchs_interface.dart';
import '../../../errors/errors_messages_classes/errors_messages.dart';
import '../../repository/match_repository_interface.dart';

class UpdateRound16MatchsUC implements IUpdateRound16Matchs {
  final IMatchRepository repository;

  UpdateRound16MatchsUC(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required List<Selecao> winners,
    required String group,
  }) async {
    int idMatch1, idMatch2;
    int? number = _groupToInt(group);

    if (number == null) {
      return Left(InvalidSearchText(Messages.genericError));
    }

    if (number.isOdd) {
      if (number > 4) {
        idMatch1 = 48 + 8 - ((number + 1) ~/ 2);
        idMatch2 = 48 + 4 + ((number + 1) ~/ 2);
      } else {
        idMatch1 = 48 + ((number + 1) ~/ 2);
        idMatch2 = 48 + 4 - ((number + 1) ~/ 2) + 1;
      }
    } else {
      if (number > 4) {
        idMatch1 = 48 + 4 + (number ~/ 2);
        idMatch2 = 48 + 8 - (number ~/ 2);
      } else {
        idMatch1 = 48 + 4 - (number ~/ 2) + 1;
        idMatch2 = 48 + (number ~/ 2);
      }
    }

    return await repository.updateRound16Matchs(
      idMatch1: idMatch1,
      idMatch2: idMatch2,
      selections: winners,
    );
  }

  int? _groupToInt(String group) {
    Map<String, int> correspondents = {
      'A': 1,
      'B': 2,
      'C': 3,
      'D': 4,
      'E': 5,
      'F': 6,
      'G': 7,
      'H': 8,
    };

    return correspondents[group];
  }
}
