import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:pdvx/db/store_data.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class DbLoginController {
  static const DB_NAME = 'tabela';

  static Future<sql.Database> database() async {
    var dbPath;
    var db;

    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      var databaseFactory = databaseFactoryFfi;
      await databaseFactory.openDatabase(inMemoryDatabasePath);
      db = inMemoryDatabasePath;
    } else {
      db = await sql.getDatabasesPath();
    }
    dbPath = join(db, 'pdvx.db');

    return sql.openDatabase(
      dbPath,
      onCreate: (db, version) async {
        return await db.execute(
            ' CREATE TABLE IF NOT EXISTS tabela (     ' +
                '   id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
                '   uuid TEXT,                            ' +
                '   campo1  TEXT,                         ' +
                '   campo2 TEXT,                          ' +
                '   campo3 TEXT,                          ' +
                '   campo4 TEXT,                          ' +
                '   campo5 TEXT,                          ' +
                '   campo6 CHAR,                          ' +
                '   campo7 CHAR,                          ' +
                '   campo8 TEXT,                          ' +
                '   campo9 TEXT,                          ' +
                '   campo10 TEXT,                         ' +
                '   campo11 TEXT,                         ' +
                '   campo12 TEXT,                         ' +
                '   campo13 TEXT                          ' +
                '  )                                      ');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // db.execute('ALTER TABLE tabela ADD COLUMN campo14 REAL ');
        // db.execute('ALTER TABLE tabela ADD COLUMN campo15 REAL ');
        // db.execute('ALTER TABLE tabela ADD COLUMN campo16 TEXT ');
      },
      version: 1,
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await DbLoginController.database();
    await db.insert(
      DB_NAME,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DbLoginController.database();
    return db.query(DB_NAME);
  }

  static Future<void> setData(final Response _response) async {
    final Map<String, dynamic> _data = json.decode(_response.body);


    DbLoginController.insert({
      'id': 0,
      'uuid':   _data['uuid'],
      'campo1': _data['campo1'],
      'campo2': _data['campo2'],
      'campo3': _data['campo3'],
      'campo4': _data['campo4'],
      'campo5': _data['campo5'],
      'campo6': _data['campo6'],
      'campo7': _data['campo7'],
      'campo8': _data['campo8'],
      'campo9': _data['campo9'],
      'campo10': _data['campo10'],
    });
  }
}