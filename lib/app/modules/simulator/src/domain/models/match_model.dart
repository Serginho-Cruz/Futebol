import 'package:futebol/app/modules/simulator/src/domain/entities/Match/match_entity.dart';

import '../entities/Selection/selection_entity.dart';

class SoccerMatchModel extends SoccerMatch {
  final int id;
  final Selecao selection1;
  final Selecao selection2;
  final String local;
  final String date;
  final String hour;
  final int type;
  final int? score1;
  final int? score2;
  final int? extratimeScore1;
  final int? extraTimeScore2;
  final int? penaltyScore1;
  final int? penaltyScore2;

  SoccerMatchModel({
    required this.id,
    required this.selection1,
    required this.selection2,
    required this.local,
    required this.date,
    required this.hour,
    required this.type,
    this.score1,
    this.score2,
    this.extratimeScore1,
    this.extraTimeScore2,
    this.penaltyScore1,
    this.penaltyScore2,
  }) : super(
          id: id,
          idSelection1: selection1.id!,
          idSelection2: selection2.id!,
          local: local,
          date: date,
          hour: hour,
          type: type,
          score1: score1,
          score2: score2,
          extratimeScore1: extratimeScore1,
          extraTimeScore2: extraTimeScore2,
          penaltyScore1: penaltyScore1,
          penaltyScore2: penaltyScore2,
        );
}
