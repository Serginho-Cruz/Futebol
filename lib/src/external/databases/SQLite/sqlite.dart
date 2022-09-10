import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/Selection/selection_entity.dart';
import '../../../domain/entities/Selection/selection_mapper.dart';
import '../../../errors/errors_classes/errors_classes.dart';
import '../../../errors/errors_messages_classes/errors_messages.dart';
import '../scritps_db.dart';
import 'tables_schema.dart';

class DB {
  static final DB instance = DB._init();
  DB._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('copa.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateSchema,
    );
  }

  Future<Selecao> create(Selecao selecao) async {
    final db = await instance.database;
    final id = await db.insert(
        SelectionTableSchema.nameTable, SelecaoMapper.toMap(selecao));

    if (id == 0) {
      throw DataSourceError(Messages.genericError);
    } else if (id > 0) {
      return Selecao(
        id: id,
        bandeira: selecao.bandeira,
        grupo: selecao.grupo,
        nome: selecao.nome,
        gc: selecao.gc,
        gp: selecao.gp,
        pontos: selecao.pontos,
        sg: selecao.sg,
        vitorias: selecao.vitorias,
      );
    } else {
      throw Exception();
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }

  Future<void> _onCreateSchema(db, versao) async {
    await db.execute(createSelectionTableScript());
    await _populateTables(db);
  }

  Future<void> _populateTables(Database db) async {
    populateSelectionTableScript(db);
  }
}
