import '../../../domain/entities/Match/match_entity.dart';
import '../../../domain/entities/Match/match_mapper.dart';
import '../../../domain/entities/Selection/selection_entity.dart';
import '../../../domain/entities/Selection/selection_mapper.dart';
import '../../../errors/errors_classes/errors_classes.dart';
import '../../../errors/errors_messages_classes/errors_messages.dart';
import '../../databases/SQLite/sqlite.dart';
import '../../databases/SQLite/tables_schema.dart';
import '../../../infra/datasource/datasource_interface.dart';

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
  Future<List<Selecao>> updateSelectionsStatistics(
    List<Selecao> selections,
    String group,
  ) async {
    final db = await SQLite.instance.database;

    try {
      await db.transaction((txn) async {
        for (var selection in selections) {
          await txn.update(
            SelectionTableSchema.nameTable,
            SelecaoMapper.toMap(selection),
            where: '${SelectionTableSchema.idColumn} = ?',
            whereArgs: [selection.id!],
          );
        }
      });

      return await getSelectionsByGroup(group);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<int>> changeScoreboard(SoccerMatch match) async {
    final db = await SQLite.instance.database;
    try {
      var oldScoresMap = await db.query(
        MatchTableSchema.nameTable,
        columns: [
          MatchTableSchema.idSelection1Column,
          MatchTableSchema.idSelection2Column,
        ],
        where: '${MatchTableSchema.idColumn} = ?',
        whereArgs: [match.id],
      );

      if (oldScoresMap.isNotEmpty) {
        await db.transaction(
          (txn) async => await txn.update(
            MatchTableSchema.nameTable,
            MatchMapper.toMap(match),
            where: '${MatchTableSchema.idColumn} = ?',
            whereArgs: [match.id],
          ),
        );

        return oldScoresMap.map((e) => e as int).toList();
      } else {
        throw NoMatchFound(Messages.noMatchFound);
      }
    } catch (e) {
      rethrow;
    }
  }
}