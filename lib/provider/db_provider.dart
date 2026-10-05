import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/models/scan_models.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();
  DbProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //direccion de la BD
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "ScansDB.db");
    print(path);

    //create database

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
      CREATE TABLE IF NOT EXISTS Scans(
        id INTEGER PRIMARY KEY,
        tipo TEXT,
        valor TEXT
      )
''');
      },
    );
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final db = await database;
    final res = await db.rawInsert("""
        INSERT INTO Scans(id, tipo, valor)
         VALUES ($id , $tipo , $valor)
""");

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert("Scans", nuevoScan.toJson());
    print(res);

    return res;
  }

  Future<ScanModel?> getScandById(int id) async {
    final db = await database;

    final res = await db.query("Scans", where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;

    final res = await db.query("Scans");

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScansType(String tipo) async {
    final db = await database;

    // final res = await db.rawQuery('SELECT * FROM Scans WHERE tipo = ?', [tipo]);
    final res = await db.query("Scans", where: "tipo = ?", whereArgs: [tipo]);
    print(res);
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update(
      "Scans",
      nuevoScan.toJson(),
      where: "id = ?",
      whereArgs: [nuevoScan.id],
    );
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete("Scans", where: "id = ?", whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete("Scans");

    return res;
  }
}
