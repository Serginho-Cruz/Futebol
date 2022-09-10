// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SoccerMatch extends Equatable {
  final int id;
  final int idSelection1;
  final int idSelection2;
  final String local;
  final String hour;
  final String date;
  final int type;
  final int score1;
  final int score2;
  final int extratimeScore1;
  final int extraTimeScore2;
  final int penaltyScore1;
  final int penaltyScore2;

  const SoccerMatch({
    required this.id,
    required this.idSelection1,
    required this.idSelection2,
    required this.local,
    required this.date,
    required this.hour,
    required this.type,
    this.score1 = 0,
    this.score2 = 0,
    this.extratimeScore1 = 0,
    this.extraTimeScore2 = 0,
    this.penaltyScore1 = 0,
    this.penaltyScore2 = 0,
  });

  @override
  List<Object?> get props => [
        id,
        idSelection1,
        idSelection2,
        local,
        type,
        date,
        hour,
        score1,
        score2,
        extratimeScore1,
        extraTimeScore2,
        penaltyScore1,
        penaltyScore2,
      ];
}

abstract class MatchType {
  static const int group = 1;
  static const int round16 = 2;
  static const int quarterFinal = 3;
  static const int semifinal = 4;
  static const int finalMatch = 5;
}
