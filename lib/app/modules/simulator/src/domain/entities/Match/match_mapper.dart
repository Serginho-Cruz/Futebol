import 'match_entity.dart';

abstract class MatchMapper {
  static Map<String, dynamic> toMap(SoccerMatch match) {
    return <String, dynamic>{
      'idJogo': match.id,
      'Time_id1': match.idSelection1,
      'Time_id2': match.idSelection2,
      'horario': match.hour,
      'local': match.local,
      'data': match.date,
      'tipo': match.type,
      'placar1': match.score1,
      'placar2': match.score2,
      'placar1_extra': match.extratimeScore1,
      'placar2_extra': match.extratimeScore2,
      'placar1_penaltis': match.penaltyScore1,
      'placar2_penaltis': match.penaltyScore2,
      'grupo': match.group,
    };
  }

  static SoccerMatch fromMap(Map<String, dynamic> map) {
    return SoccerMatch(
      id: map['idJogo'] as int,
      idSelection1: map['Time_id1'] as int,
      idSelection2: map['Time_id2'] as int,
      local: map['local'] as String,
      type: map['tipo'] as int,
      score1: map['placar1'] == null ? null : map['placar1'] as int,
      score2: map['placar2'] == null ? null : map['placar2'] as int,
      extratimeScore1:
          map['placar1_extra'] == null ? null : map['placar1_extra'] as int,
      extratimeScore2:
          map['placar2_extra'] == null ? null : map['placar2_extra'] as int,
      penaltyScore1: map['placar1_penaltis'] == null
          ? null
          : map['placar1_penaltis'] as int,
      penaltyScore2: map['placar2_penaltis'] == null
          ? null
          : map['placar2_penaltis'] as int,
      date: map['data'] as String,
      hour: map['horario'] as String,
      group: map['grupo'] == null ? null : map['grupo'] as String,
    );
  }
}
