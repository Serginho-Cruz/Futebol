class SoccerMatch {
  final int id;
  final int idSelection1;
  final int idSelection2;
  final String local;
  final String hour;
  final String date;
  final String? group;
  final int type;
  final int? score1;
  final int? score2;
  final int? extratimeScore1;
  final int? extratimeScore2;
  final int? penaltyScore1;
  final int? penaltyScore2;

  const SoccerMatch({
    required this.id,
    required this.idSelection1,
    required this.idSelection2,
    required this.local,
    required this.date,
    required this.hour,
    required this.type,
    this.group,
    this.score1,
    this.score2,
    this.extratimeScore1,
    this.extratimeScore2,
    this.penaltyScore1,
    this.penaltyScore2,
  });
}

abstract class SoccerMatchType {
  static const int group = 1;
  static const int round16 = 2;
  static const int quarterFinals = 3;
  static const int semifinals = 4;
  static const int thirdPlace = 5;
  static const int finalMatch = 6;
}
