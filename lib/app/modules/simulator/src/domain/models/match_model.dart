import 'package:futebol/app/modules/simulator/src/domain/entities/Match/match_entity.dart';

import '../entities/Selection/selection_entity.dart';

class SoccerMatchModel {
  final int id;
  final Selecao selection1;
  final Selecao selection2;
  final String local;
  final String date;
  final String hour;
  final int type;

  SoccerMatchModel({
    required this.id,
    required this.selection1,
    required this.selection2,
    required this.local,
    required this.date,
    required this.hour,
    required this.type,
  });
}
