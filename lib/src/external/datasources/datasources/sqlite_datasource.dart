import 'package:futebol/src/domain/entities/selecao_entity.dart';
import 'package:futebol/src/domain/entities/selecao_mapper.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';
import 'package:futebol/src/errors/errors_mensages_classes/errors_mensages.dart';
import 'package:futebol/src/external/databases/SQLite/sqlite.dart';
import 'package:futebol/src/external/databases/SQLite/tables_schema.dart';
import 'package:futebol/src/infra/datasource/datasource_interface.dart';

class SQLitedatasource implements IDataSource {
  @override
  Future<List<Selecao>> getAllSelections() async {
    final db = await DB.instance.database;
    final list = await db.transaction((txn) => txn.query(SelectionTableSchema.NAME);

    if (list.isNotEmpty) {
      return list.map((e) => SelecaoMapper.fromMap(e)).toList();
    } else if (list.isEmpty) {
      throw SelectionError(Messages.noSelectionsFound);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Selecao>> getSelectionsByGroup(String group) async {
    final db = await DB.instance.database;
    final list = await db.transaction((txn) => txn.query(
          SelectionTable.name,
          where: '${SelectionTable.groupColumn} = ?',
          whereArgs: [group],
        ));
    if (list.isEmpty) {
      throw SelectionError(Messages.noGroupSelections);
    } else if (list.isNotEmpty) {
      return list.map((e) => SelecaoMapper.fromMap(e)).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Future<Selecao> getSelectionById(int id) async {
    final db = await DB.instance.database;
    final mapList = await db.transaction((txn) =>
        txn.query(SelectionTable.name, where: 'id = ?', whereArgs: [id]));

    if (mapList.isNotEmpty) {
      return SelecaoMapper.fromMap(mapList.first);
    } else {
      throw SelectionError(Messages.noSelectionFound);
    }
  }
}
