import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_flutter_app/models/db_model.dart';

class MainDataBase {
  MainDataBase.init();

  static MainDataBase instance = MainDataBase.init();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase("mydatabase");
    return _database;
  }

  Future<Database?> initDatabase(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
        const String textType = 'TEXT NOT NULL';

        await db.execute('''
        CREATE TABLE $tableName (
          ${DatabaseField.id} $idType,
          ${DatabaseField.username} $textType,
          ${DatabaseField.password} $textType
        )
        ''');
      },
    );
  }

  Future<DatabaseModel> sendData(DatabaseModel information) async {
    final db = await MainDataBase.instance.database;

    //returnType: (int<id>)
    final info = await db!.insert(
      tableName,
      information.toJson(),
    );

    return information.copy(newId: info);
  }

  Future<DatabaseModel> getOne(int id) async {
    final db = await MainDataBase.instance.database;
    final info = await db!.query(
      tableName,
      columns: DatabaseField.values,
      where: "${DatabaseField.id} = ?",
      whereArgs: [id],
    );

    if (info.isNotEmpty) {
      return DatabaseModel.fromJson(info.first);
    } else {
      throw Exception(
        "Can't show the information",
      );
    }
  }

  Future<List<DatabaseModel>> getAll() async {
    final db = await MainDataBase.instance.database;
    final infos = await db!.query(tableName);

    return infos.map((value) => DatabaseModel.fromJson(value)).toList();
  }
}
