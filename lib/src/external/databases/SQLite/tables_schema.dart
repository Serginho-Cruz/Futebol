abstract class SelectionTableSchema {
  static const String nameTable = "Selecao";
  static const String idColumn = "id";
  static const String groupColumn = "grupo";
  static const String nameColumn = "nome";
  static const String flagColumn = "bandeira";
  static const String pointsColumn = "pontos";
  static const String victoriesColumn = "vitorias";
  static const String gpColumn = "gp";
  static const String gcColumn = "gc";
}

abstract class MatchTableSchema {
  static const String nameTable = "Jogo";
  static const String idColumn = "idJogo";
  static const String idSelection1Column = "Time_id1";
  static const String idSelection2Column = "Time_id2";
  static const String timeColumn = "horario";
  static const String localColumn = "local";
  static const String dateColumn = "data";
  static const String typeColumn = "tipo";
  static const String groupColumn = "grupo";
  static const String score1Column = "placar1";
  static const String score2Column = "placar2";
  static const String extraTimeScore1Column = "placar1_extra";
  static const String extraTimeScore2Column = "placar2_extra";
  static const String penaltys1Column = "placar1_penaltis";
  static const String penaltys2Column = "placar2_penaltis";
}
