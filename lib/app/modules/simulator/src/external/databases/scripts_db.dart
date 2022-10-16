import 'SQLite/Matchs/elimination_matchs.dart';
import 'SQLite/Matchs/group_matchs.dart';
import 'package:sqflite/sqflite.dart';
import 'SQLite/selections.dart';
import 'SQLite/tables_schema.dart';

String createSelectionTableScript() => '''
  CREATE TABLE ${SelectionTableSchema.nameTable} (
    ${SelectionTableSchema.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, 
    ${SelectionTableSchema.nameColumn} TEXT NOT NULL, 
    ${SelectionTableSchema.flagColumn} TEXT NOT NULL, 
    ${SelectionTableSchema.groupColumn} TEXT NOT NULL,
    ${SelectionTableSchema.pointsColumn} INTEGER NULL,
    ${SelectionTableSchema.victoriesColumn} INTEGER NULL,
    ${SelectionTableSchema.gpColumn} INTEGER NULL,
    ${SelectionTableSchema.gcColumn} INTEGER NULL
    )
  ''';

String createMatchTableScript() => '''
  CREATE TABLE ${MatchTableSchema.nameTable} (
    ${MatchTableSchema.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${MatchTableSchema.idSelection1Column} INTEGER NOT NULL,
    ${MatchTableSchema.idSelection2Column} INTEGER NOT NULL,
    ${MatchTableSchema.localColumn} TEXT NOT NULL,
    ${MatchTableSchema.timeColumn} TEXT NOT NULL,
    ${MatchTableSchema.dateColumn} TEXT NOT NULL,
    ${MatchTableSchema.groupColumn} TEXT NULL,
    ${MatchTableSchema.typeColumn} INTEGER NOT NULL,
    ${MatchTableSchema.score1Column} INTEGER NULL,
    ${MatchTableSchema.score2Column} INTEGER NULL,
    ${MatchTableSchema.extraTimeScore1Column} INTEGER NULL,
    ${MatchTableSchema.extraTimeScore2Column} INTEGER NULL,
    ${MatchTableSchema.penaltys1Column} INTEGER NULL,
    ${MatchTableSchema.penaltys2Column} INTEGER NULL,
    FOREIGN KEY(${MatchTableSchema.idSelection1Column}) REFERENCES ${SelectionTableSchema.nameTable}(${SelectionTableSchema.idColumn}),
    FOREIGN KEY(${MatchTableSchema.idSelection2Column}) REFERENCES ${SelectionTableSchema.nameTable}(${SelectionTableSchema.idColumn})
  )
''';

Future<void> populateSelectionTableScript(Database db) async {
  String sql = '''
          INSERT INTO ${SelectionTableSchema.nameTable} (
            ${SelectionTableSchema.nameColumn}, 
            ${SelectionTableSchema.flagColumn}, 
            ${SelectionTableSchema.groupColumn},
            ${SelectionTableSchema.pointsColumn},
            ${SelectionTableSchema.victoriesColumn},
            ${SelectionTableSchema.gpColumn},
            ${SelectionTableSchema.gcColumn}
          ) VALUES (?, ?, ?, ?, ?, ?, ?)
        ''';

  selections.forEach((raw) async {
    await db.rawInsert(sql, [
      raw[SelectionTableSchema.nameColumn],
      raw[SelectionTableSchema.flagColumn],
      raw[SelectionTableSchema.groupColumn],
      0,
      0,
      0,
      0,
    ]);
  });
}

Future<void> populateMatchTableScript(Database db) async {
  String sql = ''' 
      INSERT INTO ${MatchTableSchema.nameTable} (
        ${MatchTableSchema.idSelection1Column},
        ${MatchTableSchema.idSelection2Column},
        ${MatchTableSchema.dateColumn},
        ${MatchTableSchema.timeColumn},
        ${MatchTableSchema.localColumn},
        ${MatchTableSchema.typeColumn},
        ${MatchTableSchema.groupColumn}
      ) VALUES (?, ?, ?, ?, ?, ?, ?)
  ''';

  var batch = db.batch();
  for (var match in groupMatchs) {
    batch.rawInsert(sql, [
      match[MatchTableSchema.idSelection1Column],
      match[MatchTableSchema.idSelection2Column],
      match[MatchTableSchema.dateColumn],
      match[MatchTableSchema.timeColumn],
      match[MatchTableSchema.localColumn],
      match[MatchTableSchema.typeColumn],
      match[MatchTableSchema.groupColumn],
    ]);
  }

  for (var match in eliminationMatchs) {
    batch.rawInsert(sql, [
      match[MatchTableSchema.idSelection1Column],
      match[MatchTableSchema.idSelection2Column],
      match[MatchTableSchema.dateColumn],
      match[MatchTableSchema.timeColumn],
      match[MatchTableSchema.localColumn],
      match[MatchTableSchema.typeColumn],
      match[MatchTableSchema.groupColumn],
    ]);
  }
  await batch.commit(noResult: true);
}
