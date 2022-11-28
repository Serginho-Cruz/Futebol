import '../entities/Match/match_entity.dart';
import '../entities/Selection/selection_entity.dart';

class SoccerMatchModel extends SoccerMatch {
  late int id;
  Selecao selection1;
  Selecao selection2;
  late String local;
  late String date;
  late String hour;
  late String? group;
  late int type;
  late int? score1;
  late int? score2;
  late int? extratimeScore1;
  late int? extratimeScore2;
  late int? penaltyScore1;
  late int? penaltyScore2;

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
          group: match.group,
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
    group = match.group;
    score1 = match.score1;
    score2 = match.score2;
    extratimeScore1 = match.extratimeScore1;
    extratimeScore2 = match.extratimeScore2;
    penaltyScore1 = match.penaltyScore1;
    penaltyScore2 = match.penaltyScore2;
  }
}
