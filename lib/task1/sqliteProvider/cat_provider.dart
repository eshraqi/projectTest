import 'package:sqflite/sqflite.dart';
import '../../models/cat.dart';
import 'package:path/path.dart';

class CatProvider {
  late Database db;
  late String _path;

  Future open({String dbName = 'catDataBase.db'}) async {
    var databasesPath = await getDatabasesPath();
    _path = join(databasesPath, dbName);
    db = await openDatabase(
      join(await getDatabasesPath(), 'catDataBase.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cats(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }


  // Define a function that inserts cats into the database
  Future<void> insertCat(Cat cat) async {
    await db.insert(
      'cats',
      cat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the cats from the cats table.
  Future<List<Cat>> getCats() async {
    final List<Map<String, dynamic>> maps = await db.query('cats');
    return List.generate(maps.length, (i) {
      return Cat(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
        age: maps[i]['age'] as int,
      );
    });
  }

  Future<void> updateCat(Cat cat) async {
    await db.update(
      'cats',
      cat.toMap(),
      where: 'id = ?',
      whereArgs: [cat.id],
    );
  }

  Future<void> deleteCat(int id) async {
    // Remove the cat from the database.
    await db.delete(
      'cats',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // Close the database
  Future close() async => db.close();

  // Delete the database
  Future deleteDatabase(String path) async {
    await deleteDatabase(_path);
  }
}