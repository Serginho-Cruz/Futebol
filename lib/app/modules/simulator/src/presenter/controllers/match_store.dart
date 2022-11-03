import 'package:flutter_triple/flutter_triple.dart';

import '../../domain/entities/Match/match_entity.dart';
import '../../domain/usecases/Match/change_scoreboard_interface.dart';
import '../../domain/usecases/Match/get_matchs_by_group.dart';
import '../../domain/usecases/Match/get_matchs_by_type_interface.dart';
import '../../errors/errors_classes/errors_classes.dart';

class MatchStore extends NotifierStore<Failure, List<SoccerMatch>> {
  late final IGetMatchsByType _getByType;
  late final IGetMatchsByGroup _getByGroup;
  late final IChangeScoreboard _changeScoreboard;

  MatchStore({
    required IGetMatchsByType getByType,
    required IGetMatchsByGroup getByGroup,
    required IChangeScoreboard changeScoreboard,
  }) : super([]) {
    _getByType = getByType;
    _getByGroup = getByGroup;
    _changeScoreboard = changeScoreboard;
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

  Future<List<int>?> changeGroupScoreboard({
    required SoccerMatch match,
    required int score1,
    required int score2,
  }) async {
    List<int>? oldScores;
    setLoading(true);

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

    setLoading(false);
    return oldScores;
  }

  Future<void> changeKnockoutScoreboard({
    required SoccerMatch match,
    required int score1,
    required int score2,
    List<int>? extratimeScores,
    List<int>? penaltyScores,
  }) async {
    setLoading(true);

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

    setLoading(false);
  }
}
