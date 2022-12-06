import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../domain/usecases/Match/update_finals_interface.dart';
import '../../domain/usecases/Match/update_semifinals_interface.dart';
import '../../domain/usecases/Match/get_final_matchs_interface.dart';
import '../../domain/usecases/Match/update_quarters_interface.dart';
import 'selection_store.dart';

import '../../domain/entities/Match/match_entity.dart';
import '../../domain/entities/Selection/selection_entity.dart';
import '../../domain/usecases/Match/change_scoreboard_interface.dart';
import '../../domain/usecases/Match/get_matchs_by_group.dart';
import '../../domain/usecases/Match/get_matchs_by_type_interface.dart';
import '../../domain/usecases/Match/update_round16_interface.dart';
import '../../domain/usecases/Selection/define_group_winners_interface.dart';
import '../../errors/errors_classes/errors_classes.dart';

class MatchStore extends NotifierStore<Failure, List<SoccerMatch>> {
  late final IGetMatchsByType _getByType;
  late final IGetMatchsByGroup _getByGroup;
  late final IChangeScoreboard _changeScoreboard;
  late final IDefineGroupWinners _defineGroupWinners;
  late final IUpdateRound16 _updateRound16Matchs;
  late final IUpdateQuarters _updateQuarterMatchs;
  late final IUpdateSemifinals _updateSemifinals;
  late final IUpdateFinals _updateFinals;
  late final IGetFinalMatchs _getFinalMatchs;
  MatchStore({
    required IGetMatchsByType getByType,
    required IGetMatchsByGroup getByGroup,
    required IChangeScoreboard changeScoreboard,
    required IDefineGroupWinners defineGroupWinners,
    required IUpdateRound16 updateRound16Matchs,
    required IUpdateQuarters updateQuarterMatchs,
    required IUpdateSemifinals updateSemifinals,
    required IUpdateFinals updateFinals,
    required IGetFinalMatchs getFinalMatchs,
  }) : super([]) {
    _getByType = getByType;
    _getByGroup = getByGroup;
    _changeScoreboard = changeScoreboard;
    _defineGroupWinners = defineGroupWinners;
    _updateRound16Matchs = updateRound16Matchs;
    _updateQuarterMatchs = updateQuarterMatchs;
    _updateSemifinals = updateSemifinals;
    _updateFinals = updateFinals;
    _getFinalMatchs = getFinalMatchs;
  }

  Future<void> getMatchsByType(int type) async {
    setLoading(true);

    var result = await _getByType(type);

    result.fold((l) {
      setError(l);
    }, (r) {
      update(r);
    });

    setLoading(false);
  }

  Future<void> getMatchsByGroup(String group) async {
    setLoading(true);

    var result = await _getByGroup(group);

    result.fold((l) {
      setError(l);
    }, (r) {
      update(r);
    });

    setLoading(false);
  }

  Future<List<int?>?> changeGroupScoreboard({
    required SoccerMatch match,
    required int score1,
    required int score2,
  }) async {
    List<int?>? oldScores;

    var result = await _changeScoreboard(
      match: match,
      score1: score1,
      score2: score2,
    );

    result.fold((error) {
      setError(error);
    }, (scores) {
      oldScores = scores;
    });
    return oldScores;
  }

  Future<void> changeKnockoutScoreboard({
    required SoccerMatch match,
    required int score1,
    required int score2,
    List<int>? extratimeScores,
    List<int>? penaltyScores,
  }) async {
    var result = await _changeScoreboard(
      match: match,
      score1: score1,
      score2: score2,
      extratimeScores: extratimeScores,
      penaltyScores: penaltyScores,
    );

    result.fold((l) {
      setError(l);
    }, (r) {});
  }

  Future<void> updateRound16({
    required List<Selecao> selections,
    required String group,
  }) async {
    var result = await _updateRound16Matchs(
      group: group,
      winners: _defineGroupWinners(selections),
    );

    result.fold((l) {
      setError(l);
    }, (r) {});
  }

  Future<void> updateQuarters({
    required SoccerMatch match,
  }) async {
    int winnerId = defineKnockoutWinner(match);

    var result = await _updateQuarterMatchs(
      matchId: match.id,
      winnerId: winnerId,
    );

    result.fold((l) {
      setError(l);
    }, (r) {});
  }

  Future<void> updateSemifinals({required SoccerMatch match}) async {
    int winnerId = defineKnockoutWinner(match);

    var result = await _updateSemifinals(matchId: match.id, winnerId: winnerId);

    result.fold((l) {
      setError(l);
    }, (r) {});
  }

  Future<void> updateFinals({required SoccerMatch match}) async {
    int winnerId = defineKnockoutWinner(match);
    int loserId = winnerId == match.idSelection1
        ? match.idSelection2
        : match.idSelection1;

    var result = await _updateFinals(
      idMatch: match.id,
      loserId: loserId,
      winnerId: winnerId,
    );

    result.fold((l) {
      setError(l);
    }, (r) {});
  }

  Future<void> getFinalMatchs() async {
    var result = await _getFinalMatchs();

    result.fold((l) {
      setError(l);
    }, (r) {
      update(r);
    });
  }

  int defineKnockoutWinner(SoccerMatch match) {
    int result = match.score1!.compareTo(match.score2!);
    if (result > 0) {
      return match.idSelection1;
    } else if (result < 0) {
      return match.idSelection2;
    } else {
      int extraTimeResult =
          match.extratimeScore1!.compareTo(match.extratimeScore2!);

      if (extraTimeResult > 0) {
        return match.idSelection1;
      } else if (extraTimeResult < 0) {
        return match.idSelection2;
      } else {
        if (match.penaltyScore1! > match.penaltyScore2!) {
          return match.idSelection1;
        }
        return match.idSelection2;
      }
    }
  }
}
