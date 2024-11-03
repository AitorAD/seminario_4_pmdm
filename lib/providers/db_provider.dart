import 'package:seminario_4/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBProvider {
  // Propiedad estática de tipo Database
  static Database? _database;

  // Singleton
  static final DBProvider db = DBProvider._();
  DBProvider._();

  // Método para obtener la instancia de la base de datos
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  // Método para inicializar la base de datos
  Future<Database> initDB() async {
    // Obtener el directorio de documentos de la aplicación
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Unir el path del directorio con el nombre de la base de datos
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print("Database path: $path"); // Imprimir el path para referencia

    // Abrir o crear la base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        // Crear la tabla Scans con SQL
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  // Método para insertar un nuevo registro de forma "tosca" usando rawInsert
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    // Extraer los valores del objeto ScanModel
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Obtener la instancia de la base de datos
    final db = await database;

    // Insertar el registro en la base de datos usando SQL directo (rawInsert)
    final res = await db!.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUES ('$id', '$tipo', '$valor')
    ''');

    return res;
  }

  // Método para insertar un nuevo registro usando el método insert de SQLite
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    // Obtener la instancia de la base de datos
    final db = await database;

    // Insertar el registro en la base de datos usando el método insert
    final res = await db!.insert('Scans', nuevoScan.toJson());

    print(res);
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    // Obtiene todos los registros (SELECT * from Scans)
    // final resAll = await db.query('Scans');
    // Obtiene el registro según un id
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);
    // Obtiene el registro/s según varios parámetros
    //final resPorVarios = await db.query('Scans', where: 'id = ? and valor = ?', whereArgs: [id, valor]);
    // Si devuelve algún registro la consulta, lo pasamos a objeto Scan, sino null
    return res.isNotEmpty ? ScanModel.fromMap(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db!.query('Scans');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromMap(s)).toList() : [];
  }

  Future<List<ScanModel>> getScansByTipo(String tipo) async {
    final db = await database;

    // Aquí lo hacemos por el método raw, para probarlo
    final res = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromMap(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db!.update('Scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db!.delete('Scans');
    return res;
  }
}
