import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static const String dbName = 'insuranceDraft.db';
  static const int dbVersion = 1;

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, dbName),
      onCreate: (db, version) => db.execute(
        'CREATE TABLE step1(id INTEGER PRIMARY KEY, fullname TEXT, carMake TEXT, carModel TEXT, typeOfCover TEXT, colorOfVehicle,TEXT, valueOfCar TEXT, registrationNumber TEXT, chassisNumber TEXT, engineNumber TEXT, valueOfVehicle INTEGER, periodOfInsurance TEXT,)',
      ),
      version: dbVersion,
    );
  }

  static Future<void> insertStep1(Map<String, dynamic> data) async {
    final Database sqldb = await database();
    sqldb.insert(
      'step1',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final Database sqldb = await database();
    return sqldb.query(table);
  }
}
