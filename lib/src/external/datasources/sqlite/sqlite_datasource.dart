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
  Future<List<Selecao>> getSelectionsByids(List<int> ids) {
    // TODO: implement getSelectionsByids
    throw UnimplementedError();
  }

  @override
  Future<int> updateSelectionsStatistics(List<Selecao> selections) {
    // TODO: implement updateSelectionsStatistics
    throw UnimplementedError();
  }

  @override
  Future<int> changeScoreboard(
      {required int matchId, required int newScore1, required int newScore2}) {
    // TODO: implement changeScoreboard
    throw UnimplementedError();
  }

  @override
  Future<SoccerMatch> getMatchById(int id) {
    // TODO: implement getMatchById
    throw UnimplementedError();
  }
}
