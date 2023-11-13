import 'package:path/path.dart';
import 'package:pos_sqlite/data/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  final categoriesTable = 'Categories';

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $categoriesTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL)',
        );
      },
      version: 1,
    );
  }

  Future<int> createCategory(CategoryModel category) async {
    final db = await initializeDB();
    final id = await db.insert(
      categoriesTable,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return Future.value(id);
  }

  Future<List<CategoryModel>> getCategories() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      categoriesTable,
      orderBy: 'title',
    );
    return queryResult.map((e) => CategoryModel.fromMap(e)).toList();
  }
}
