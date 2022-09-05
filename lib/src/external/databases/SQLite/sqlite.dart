import 'package:futebol/src/domain/entities/selecao_entity.dart';
import 'package:futebol/src/domain/entities/selecao_mapper.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';
import 'package:futebol/src/errors/errors_mensages_classes/errors_mensages.dart';
import 'package:futebol/src/external/databases/SQLite/tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE ${SelectionTable.name} (
        ${SelectionTable.idColumn} INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT, 
        ${SelectionTable.nameColumn} TEXT NOT NULL, 
        ${SelectionTable.flagColumn} TEXT NOT NULL, 
        ${SelectionTable.groupColumn} TEXT NOT NULL,
        ${SelectionTable.pointsColumn} INTEGER NULL,
        ${SelectionTable.victoriesColumn} INTEGER NULL,
        ${SelectionTable.gpColumn} INTEGER NULL,
        ${SelectionTable.gcColumn} INTEGER NULL,
        ${SelectionTable.sgColumn} INTEGER NULL
        )
      ''');
    });
  }

  Future<Selecao> create(Selecao selecao) async {
    final db = await instance.database;
    final id =
        // ignore: unnecessary_string_interpolations
        await db.insert("${SelectionTable.name}", SelecaoMapper.toMap(selecao));

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
}
