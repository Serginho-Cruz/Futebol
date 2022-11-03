import '../entities/Match/match_entity.dart';

import '../entities/Selection/selection_entity.dart';

class SoccerMatchModel extends SoccerMatch {
  late final int id;
  final Selecao selection1;
  final Selecao selection2;
  late final String local;
  late final String date;
  late final String hour;
  late final int type;
  late final int? score1;
  late final int? score2;
  late final int? extratimeScore1;
  late final int? extratimeScore2;
  late final int? penaltyScore1;
  late final int? penaltyScore2;

  SoccerMatchModel({
    required SoccerMatch match,
    required this.selection1,
    required this.selection2,
  }) : super(
          id: match.id,
          idSelection1: selection1.id,
          idSelection2: selection2.id,
          local: match.local,
          date: match.date,
          hour: match.hour,
          type: match.type,
          score1: match.score1,
          score2: match.score2,
          extratimeScore1: match.extratimeScore1,
          extratimeScore2: match.extratimeScore2,
          penaltyScore1: match.penaltyScore1,
          penaltyScore2: match.penaltyScore2,
        ) {
    id = match.id;
    date = match.date;
    local = match.local;
    hour = match.hour;
    type = match.type;
    score1 = match.score1;
    score2 = match.score2;
    extratimeScore1 = match.extratimeScore1;
    extratimeScore2 = match.extratimeScore2;
    penaltyScore1 = match.penaltyScore1;
    penaltyScore2 = match.penaltyScore2;
  }
}
