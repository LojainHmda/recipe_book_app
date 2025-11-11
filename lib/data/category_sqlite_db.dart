import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CategorySqliteDb {
  static late Database _db;
  static late String path;
  static String tableName = 'categories';
  static String id = 'id';
  static String country = 'country';
  static String countryRecipeImage = 'countryRecipeImage';

  static Future<Database> init() async {
    path = join(await getDatabasesPath(), 'categories.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $country TEXT,
            $countryRecipeImage TEXT
          )
        ''');
      },
    );
    return _db;
  }

  static Future<void> insert(String country, String countryRecipeImage) async {
    await _db.insert(tableName, {
      'country': country,
      'countryRecipeImage': countryRecipeImage,
    });
  }

static Future<Map<String, String>> getQueries() async {
  final List<Map<String, dynamic>> result = await _db.query(tableName);
  Map<String, String> queries = {};
  for (var i in result) {
    queries[i['country'].toString()] = i['countryRecipeImage'].toString();
  }
  return queries;
}


static Future<bool> isEmpty() async {
  final result = await _db.query(tableName, limit: 1);
  return result.isEmpty;
}

}
