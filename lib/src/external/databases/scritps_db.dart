import 'package:sqflite/sqflite.dart';

import 'SQLite/selection_names.dart';
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
    ${SelectionTableSchema.gcColumn} INTEGER NULL,
    ${SelectionTableSchema.sgColumn} INTEGER NULL
    )
  ''';

void populateSelectionTableScript(Database db) {
  String sql = '''
          INSERT INTO ${SelectionTableSchema.nameTable} (
            ${SelectionTableSchema.nameColumn}, 
            ${SelectionTableSchema.flagColumn}, 
            ${SelectionTableSchema.groupColumn},
            ${SelectionTableSchema.pointsColumn},
            ${SelectionTableSchema.victoriesColumn},
            ${SelectionTableSchema.gpColumn},
            ${SelectionTableSchema.gcColumn},
            ${SelectionTableSchema.sgColumn}
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''';
  var data = _selectionsDataToBePopulated();

  data.forEach((raw) async {
    await db.rawInsert(sql, [
      raw[SelectionTableSchema.nameColumn],
      raw[SelectionTableSchema.flagColumn],
      raw[SelectionTableSchema.groupColumn],
      raw[SelectionTableSchema.pointsColumn],
      raw[SelectionTableSchema.gpColumn],
      raw[SelectionTableSchema.gcColumn],
      raw[SelectionTableSchema.sgColumn],
    ]);
  });
}

List _selectionsDataToBePopulated() {
  final List<Map<String, dynamic>> data = List.empty(growable: true);

  SelectionGroups.groups.forEach((group, names) {
    for (var name in names) {
      data.add(_generateSelecao(name, 'aaa', group));
    }
  });
  return data;
}

Map<String, dynamic> _generateSelecao(String name, String flag, String group) {
  return {
    SelectionTableSchema.nameColumn: name,
    SelectionTableSchema.flagColumn: flag,
    SelectionTableSchema.groupColumn: group,
    SelectionTableSchema.victoriesColumn: 0,
    SelectionTableSchema.pointsColumn: 0,
    SelectionTableSchema.gpColumn: 0,
    SelectionTableSchema.gcColumn: 0,
    SelectionTableSchema.sgColumn: 0,
  };
}
