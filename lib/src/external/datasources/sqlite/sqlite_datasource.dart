import 'package:futebol/src/domain/entities/Match/match_entity.dart';
import 'package:futebol/src/domain/entities/Match/match_mapper.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/domain/entities/Selection/selection_mapper.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';
import 'package:futebol/src/errors/errors_messages_classes/errors_messages.dart';
import 'package:futebol/src/external/databases/SQLite/sqlite.dart';
import 'package:futebol/src/external/databases/SQLite/tables_schema.dart';
import 'package:futebol/src/infra/datasource/datasource_interface.dart';

class SQLitedatasource implements IDataSource {
  @override
  Future<List<Selecao>> getAllSelections() async {
    final db = await SQLite.instance.database;
    final list = await db
        .transaction((txn) => txn.query(SelectionTableSchema.nameTable));

    if (list.isNotEmpty) {
      return list.map((e) => SelecaoMapper.fromMap(e)).toList();
    } else if (list.isEmpty) {
      throw NoSelectionsFound(Messages.noSelectionsFound);
    } else {
      throw DataSourceError(Messages.genericError);
    }
  }

  @override
  Future<List<Selecao>> getSelectionsByGroup(String group) async {
    final db = await SQLite.instance.database;
    final list = await db.transaction(
      (txn) => txn.query(
        SelectionTableSchema.nameTable,
        where: '${SelectionTableSchema.groupColumn} = ?',
        whereArgs: [group],
      ),
    );
    if (list.isEmpty) {
      throw NoSelectionsFound(Messages.noGroupSelections);
    } else if (list.isNotEmpty) {
      return list.map((e) => SelecaoMapper.fromMap(e)).toList();
    } else {
      throw DataSourceError(Messages.genericError);
    }
  }

  @override
  Future<Selecao> getSelectionById(int id) async {
    final db = await SQLite.instance.database;
    final mapList = await db.transaction(
      (txn) => txn.query(
        SelectionTableSchema.nameTable,
        where: '${SelectionTableSchema.idColumn} = ?',
        whereArgs: [id],
      ),
    );

    if (mapList.isNotEmpty) {
      return SelecaoMapper.fromMap(mapList.first);
    } else {
      throw NoSelectionsFound(Messages.noSelectionFound);
    }
  }

  @override
  Future<List<SoccerMatch>> getMatchsByGroup(String group) async {
    final db = await SQLite.instance.database;
    final mapList = await db.transaction(
      (txn) => txn.query(
        MatchTableSchema.nameTable,
        where: '${MatchTableSchema.groupColumn} = ?',
        whereArgs: [group],
      ),
    );

    if (mapList.isNotEmpty) {
      return mapList.map((e) => MatchMapper.fromMap(e)).toList();
    } else if (mapList.isEmpty) {
      throw NoMatchsFound(Messages.noMatchsFound);
    } else {
      throw DataSourceError(Messages.genericError);
    }
  }

  @override
  Future<List<SoccerMatch>> getMatchsByType(int type) async {
    final db = await SQLite.instance.database;
    final mapList = await db.transaction(
      (txn) => txn.query(
        MatchTableSchema.nameTable,
        where: '${MatchTableSchema.typeColumn} = ?',
        whereArgs: [type],
      ),
    );

    if (mapList.isEmpty) {
      throw NoMatchsFound(Messages.noMatchsFound);
    } else if (mapList.isNotEmpty) {
      return mapList.map((e) => MatchMapper.fromMap(e)).toList();
    } else {
      throw DataSourceError(Messages.genericError);
    }
  }

  @override
  Future<List<Selecao>> getSelectionsByids(List<int> ids) async {
    final db = await SQLite.instance.database;
    var mapList = await db.transaction((txn) => txn.query(
          SelectionTableSchema.nameTable,
          where:
              '${SelectionTableSchema.idColumn} = ? or ${SelectionTableSchema.idColumn} = ?',
          whereArgs: [ids[0], ids[1]],
        ));

    if (mapList.isEmpty) {
      throw NoSelectionsFound(Messages.noSelectionsFound);
    } else if (mapList.isNotEmpty) {
      var list = mapList.map((e) => SelecaoMapper.fromMap(e)).toList();

      return list.first.id != ids.first ? list.reversed.toList() : list;
    } else {
      throw Exception();
    }
  }

  @override
  Future<SoccerMatch> getMatchById(int id) async {
    final db = await SQLite.instance.database;

    var mapList = await db.transaction((txn) => txn.query(
        MatchTableSchema.nameTable,
        where: '${MatchTableSchema.idColumn} = ?',
        whereArgs: [id]));

    if (mapList.isEmpty) {
      throw NoMatchFound(Messages.noMatchFound);
    } else if (mapList.isNotEmpty) {
      return MatchMapper.fromMap(mapList.first);
    } else {
      throw Exception();
    }
  }

  @override
  Future<int> updateSelectionsStatistics(List<Selecao> selections) async {
    final db = await SQLite.instance.database;

    try {
      await db.transaction((txn) async {
        for (var selection in selections) {
          await txn.update(
              SelectionTableSchema.nameTable, SelecaoMapper.toMap(selection),
              where: '${SelectionTableSchema.idColumn} = ?',
              whereArgs: [selection.id!]);
        }
      });

      return 0;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> changeScoreboard(SoccerMatch newMatch) async {
    final db = await SQLite.instance.database;

    try {
      await db.transaction((txn) async => await txn.update(
          MatchTableSchema.nameTable, MatchMapper.toMap(newMatch),
          where: '${MatchTableSchema.idColumn} = ?', whereArgs: [newMatch.id]));

      return 0;
    } catch (e) {
      rethrow;
    }
  }
}
