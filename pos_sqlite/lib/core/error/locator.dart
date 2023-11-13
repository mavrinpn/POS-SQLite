import 'package:get_it/get_it.dart';
import 'package:pos_sqlite/business/repositories/goods_repository.dart';
import 'package:pos_sqlite/business/usecases/categories_usecases.dart';
import 'package:pos_sqlite/business/usecases/items_usecases.dart';
import 'package:pos_sqlite/data/repositories/goods_repository.dart';
import 'package:pos_sqlite/data/services/sqlite_service.dart';
import 'package:pos_sqlite/presentation/blocs/categories/categories_bloc.dart';
import 'package:pos_sqlite/presentation/blocs/items/items_bloc.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  // BLoC
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

  // UseCases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => AddCategory(sl()));
  sl.registerLazySingleton(() => RemoveCategory(sl()));
  sl.registerLazySingleton(() => GetItems(sl()));
  sl.registerLazySingleton(() => AddItem(sl()));
  sl.registerLazySingleton(() => RemoveItem(sl()));

  // Repositories
  sl.registerLazySingleton<GoodsRepository>(
    () => GoodsRepositoryImp(sqliteService: sl()),
  );

  // Services
  sl.registerLazySingleton<SqliteService>(
    () => SqliteService(),
  );
}
