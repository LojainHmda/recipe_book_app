import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RecentRecipesSqliteDb {
  static late Database _db;
  static late String path;
  static const String tableName = 'recentRecipes';
  static const String id = 'id';
  static const String uid = 'uid';
  static const String recipeId = 'recipeId';

  static Future<Database> init() async {
    path = join(await getDatabasesPath(), 'recentRecipes.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $uid TEXT,
            $recipeId TEXT
          )
        ''');
      },
    );
    return _db;
  }

  static Future<void> insert(String recipeIdValue, String uidValue) async {
    await _db.delete(
      tableName,
      where: '$uid = ? AND $recipeId = ?',
      whereArgs: [uidValue, recipeIdValue],
    );

    await _db.insert(tableName, {uid: uidValue, recipeId: recipeIdValue});

    List<Map<String, dynamic>> result = await _db.query(
      tableName,
      where: '$uid = ?',
      whereArgs: [uidValue],
      orderBy: '$id ASC',
    );

    if (result.length > 10) {
      int oldestId = result.first[id];
      await _db.delete(tableName, where: '$id = ?', whereArgs: [oldestId]);
    }

    
  }

  static Future<List<String>> getQueries(String uidValue) async {
    final List<Map<String, dynamic>> result = await _db.query(
      tableName,
      where: '$uid = ?',
      whereArgs: [uidValue],
      orderBy: '$id DESC',
    );
    return result.map((e) => e[recipeId].toString()).toList();
  }

  static Future<List<String>> getQueries2(String uidValue) async {
    final List<Map<String, dynamic>> result = await _db.query(
      tableName,
      where: '$uid = ?',
      whereArgs: [uidValue],
      orderBy: '$id DESC',
    );
    return result.map((e) => e[id].toString()).toList();
  }

  static Future<bool> isEmpty(String uidValue) async {
    final result = await _db.query(
      tableName,
      where: '$uid = ?',
      whereArgs: [uidValue],
      limit: 1,
    );
    return result.isEmpty;
  }

  static Future delete() async {
    await _db.execute('DROP TABLE IF EXISTS $tableName');
    await deleteDatabase(join(await getDatabasesPath(), 'recentRecipes.db'));
  }
}
