import 'package:get_it/get_it.dart';
import 'package:pos_sqlite/business/repositories/goods_repository.dart';
import 'package:pos_sqlite/business/repositories/orders_repository.dart';
import 'package:pos_sqlite/business/usecases/categories_usecases.dart';
import 'package:pos_sqlite/business/usecases/items_usecases.dart';
import 'package:pos_sqlite/business/usecases/orders_usecases.dart';
import 'package:pos_sqlite/business/usecases/tables_usecases.dart';
import 'package:pos_sqlite/data/repositories/goods_repository.dart';
import 'package:pos_sqlite/data/repositories/orders_repository.dart';
import 'package:pos_sqlite/data/services/sqlite_service.dart';
import 'package:pos_sqlite/presentation/blocs/categories/categories_bloc.dart';
import 'package:pos_sqlite/presentation/blocs/items/items_bloc.dart';
import 'package:pos_sqlite/presentation/blocs/order_items/order_items_bloc.dart';
import 'package:pos_sqlite/presentation/blocs/orders/orders_bloc.dart';
import 'package:pos_sqlite/presentation/blocs/tables/tables_bloc.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  // BLoCs
  sl.registerFactory(() => CategoriesBloc(
        getCategories: sl(),
        addCategory: sl(),
        removeCategory: sl(),
      ));
  sl.registerFactory(() => ItemsBloc(
        getItems: sl(),
        addItem: sl(),
        removeItem: sl(),
      ));
  sl.registerFactory(() => TablesBloc(
        getTables: sl(),
        addTable: sl(),
        removeTable: sl(),
      ));
  sl.registerFactory(() => OrdersBloc(
        getTableOrders: sl(),
        getAllOrders: sl(),
        addOrder: sl(),
        removeOrder: sl(),
      ));
  sl.registerFactory(() => OrderItemsBloc(
        getOrderItems: sl(),
        addOrderItem: sl(),
        updateOrderItem: sl(),
        removeOrderItem: sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => AddCategory(sl()));
  sl.registerLazySingleton(() => RemoveCategory(sl()));

  sl.registerLazySingleton(() => GetItems(sl()));
  sl.registerLazySingleton(() => AddItem(sl()));
  sl.registerLazySingleton(() => RemoveItem(sl()));

  sl.registerLazySingleton(() => GetTables(sl()));
  sl.registerLazySingleton(() => AddTable(sl()));
  sl.registerLazySingleton(() => RemoveTable(sl()));

  sl.registerLazySingleton(() => GetTableOrders(sl()));
  sl.registerLazySingleton(() => GetAllOrders(sl()));
  sl.registerLazySingleton(() => AddOrder(sl()));
  sl.registerLazySingleton(() => RemoveOrder(sl()));

  sl.registerLazySingleton(() => GetOrderItems(sl()));
  sl.registerLazySingleton(() => AddOrderItem(sl()));
  sl.registerLazySingleton(() => UpdateOrderItem(sl()));
  sl.registerLazySingleton(() => RemoveOrderItem(sl()));

  // Repositories
  sl.registerLazySingleton<GoodsRepository>(
    () => GoodsRepositoryImp(sqliteService: sl()),
  );
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImp(sqliteService: sl()),
  );

  // Services
  sl.registerLazySingleton<SqliteService>(
    () => SqliteService(),
  );
}
