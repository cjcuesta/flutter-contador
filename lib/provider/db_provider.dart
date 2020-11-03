import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:contador/models/lectura_model.dart';
export 'package:contador/models/lectura_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._(); //Constructor privado

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    print('lo hizo');
    return _database;
  }

  initDB() async {
    //path donde va a quedar o se encuentra la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE lecturas ('
          '  id INTEGER AUTO INCREMENT'
          ', area INTEGER'
          ', orden INTEGER'
          ', conteo INTEGER'
          ', cantidad INTEGER'
          ', estado TEXT'
          ', contador TEXT'
          ', barCode TEXT'
          ', transmitido TEXT'
          ', fechahora TEXT'
          ', fhTransmitido TEXT'
          ', PRIMARY KEY (contador, area, conteo, id) '
          ')');
    });
  }

  nuevoScan(Lectura lectura) async {
    final db = await database;

    final res = db.insert('Lecturas', lectura.toJson());

    res.then((value) {
      print('Inserto: $value');
      lectura.id = value;
    });

    return res;
  }

  Future<Lectura> getScanID(int id) async {
    final db = await database;

    final res = await db.query('Lecturas', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? Lectura.fromJson(res.first) : null;
  }

  Future<Lectura> getScanKey(Lectura lectura) async {
    final db = await database;

    final res = await db.query('Lecturas',
        where: "contador = '?' and area = ? and conteo = ? and id = ? ",
        whereArgs: [
          lectura.contador,
          lectura.area,
          lectura.conteo,
          lectura.id
        ]);

    return res.isNotEmpty ? Lectura.fromJson(res.first) : null;
  }

  Future<List<Lectura>> getScanAreaConteoRaw(Lectura lectura) async {
    final db = await database;

    final res = await db.query('Select rowid, * from Lecturas',
        where: "contador = '?' and area = ? and conteo = ?",
        whereArgs: [
          lectura.contador,
          lectura.area,
          lectura.conteo,
        ]);

    List<Lectura> list =
        res.isNotEmpty ? res.map((c) => Lectura.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Lectura>> getTodoScanRaw() async {
    final db = await database;

    final res = await db.rawQuery(
        'Select id, rowid, area, conteo, contador, barCode, cantidad, orden, estado, fechahora, transmitido, fhTransmitido from Lecturas');

    List<Lectura> list =
        res.isNotEmpty ? res.map((c) => Lectura.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Lectura>> getScanAreaConteo(Lectura lectura) async {
    final db = await database;

    final res = await db.query('Lecturas',
        where: "contador = '?' and area = ? and conteo = ?",
        whereArgs: [
          lectura.contador,
          lectura.area,
          lectura.conteo,
        ]);

    List<Lectura> list =
        res.isNotEmpty ? res.map((c) => Lectura.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Lectura>> getTodosScans() async {
    final db = await database;

    final res = await db.query('Lecturas');

    List<Lectura> list =
        res.isNotEmpty ? res.map((c) => Lectura.fromJson(c)).toList() : [];

    return list;
  }

  Future<int> updateScan(Lectura lectura) async {
    final db = await database;

    final res = await db.update('Lecturas', lectura.toJson(),
        where: 'id: ?', whereArgs: [lectura.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = db.delete('Lecturas', where: ' id: ? ', whereArgs: [id]);

    return res;
  }

  Future<int> deleteScanAreaConteo(Lectura lectura) async {
    final db = await database;
    final res = db.delete('Lecturas',
        where: "contador = '?' and area = ? and conteo = ? and id = ? ",
        whereArgs: [
          lectura.contador,
          lectura.area,
          lectura.conteo,
          lectura.id
        ]);

    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = db.delete('Lecturas');

    res.then((value) => print('Borró: $value'));

    return res;
  }
}
