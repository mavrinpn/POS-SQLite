import 'package:path/path.dart';
import 'package:pos_sqlite/data/models/category_model.dart';
import 'package:pos_sqlite/data/models/item_model.dart';
import 'package:pos_sqlite/data/models/order_item_model.dart';
import 'package:pos_sqlite/data/models/order_model.dart';
import 'package:pos_sqlite/data/models/table_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  final categoriesTable = 'Categories';
  final itemsTable = 'Items';
  final tablesTable = 'Tables';
  final ordersTable = 'Orders';
  final orderItemsTable = 'OrderItems';

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $categoriesTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT)',
        );
        await database.execute(
          'CREATE TABLE $itemsTable(id INTEGER PRIMARY KEY AUTOINCREMENT, categoryId INTEGER, title TEXT, cost REAL)',
        );
        await database.execute(
          'CREATE TABLE $tablesTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT)',
        );
        await database.execute(
          'CREATE TABLE $ordersTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tableId INTEGER, client TEXT)',
        );
        await database.execute(
          'CREATE TABLE $orderItemsTable(id INTEGER PRIMARY KEY AUTOINCREMENT, itemId INTEGER, orderId INTEGER, count REAL)',
        );
      },
      version: 1,
    );
  }

  Future<int> createCategory(CategoryModel item) async {
    final db = await initializeDB();
    final id = await db.insert(
      categoriesTable,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return Future.value(id);
  }

  Future<int> deleteCategory(CategoryModel item) async {
    final db = await initializeDB();
    final count = await db.delete(
      categoriesTable,
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return Future.value(count);
  }

  Future<List<CategoryModel>> getCategories() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      categoriesTable,
      orderBy: 'title',
    );
    return queryResult.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<int> createItem(ItemModel item) async {
    final db = await initializeDB();
    final id = await db.insert(
      itemsTable,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return Future.value(id);
  }

  Future<int> deleteItem(ItemModel item) async {
    final db = await initializeDB();
    final count = await db.delete(
      itemsTable,
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return Future.value(count);
  }

  Future<List<ItemModel>> getItems(int categoryId) async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      itemsTable,
      where: 'categoryId = ?',
      whereArgs: [categoryId],
      orderBy: 'title',
    );
    return queryResult.map((e) => ItemModel.fromMap(e)).toList();
  }

  Future<int> createTable(TableModel item) async {
    final db = await initializeDB();
    final id = await db.insert(
      tablesTable,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return Future.value(id);
  }

  Future<int> deleteTable(TableModel item) async {
    final db = await initializeDB();
    final count = await db.delete(
      tablesTable,
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return Future.value(count);
  }

  Future<List<TableModel>> getTables() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      tablesTable,
      orderBy: 'title',
    );
    return queryResult.map((e) => TableModel.fromMap(e)).toList();
  }

  Future<List<OrderModel>> getTableOrders(int tableId) async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      ordersTable,
      where: 'tableId = ?',
      whereArgs: [tableId],
    );
    return queryResult.map((e) => OrderModel.fromMap(e)).toList();
  }

  Future<List<OrderModel>> getAllOrders() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      ordersTable,
    );
    return queryResult.map((e) => OrderModel.fromMap(e)).toList();
  }

  Future<int> createOrder(OrderModel item) async {
    final db = await initializeDB();
    final id = await db.insert(
      ordersTable,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return Future.value(id);
  }

  Future<int> deleteOrder(OrderModel item) async {
    final db = await initializeDB();
    final count = await db.delete(
      ordersTable,
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return Future.value(count);
  }

  Future<List<OrderItemModel>> getOrderItems(int orderId) async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      orderItemsTable,
      where: 'orderId = ?',
      whereArgs: [orderId],
    );
    //TODO JOIN
    return queryResult.map((e) => OrderItemModel.fromMap(e)).toList();
  }

  Future<int> createOrderItem(OrderItemModel item) async {
    final db = await initializeDB();
    final id = await db.insert(
      orderItemsTable,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return Future.value(id);
  }

  Future<int> updateOrderItem(OrderItemModel item) async {
    final db = await initializeDB();
    final id = await db.update(
      orderItemsTable,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return Future.value(id);
  }

  Future<int> deleteOrderItem(OrderItemModel item) async {
    final db = await initializeDB();
    final count = await db.delete(
      orderItemsTable,
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return Future.value(count);
  }
}
