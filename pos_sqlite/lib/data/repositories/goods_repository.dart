import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/category_entity.dart';
import 'package:pos_sqlite/business/entities/item_entity.dart';
import 'package:pos_sqlite/business/repositories/goods_repository.dart';
import 'package:pos_sqlite/core/error/failure.dart';
import 'package:pos_sqlite/data/services/sqlite_service.dart';
import 'package:sqflite/sqlite_api.dart';

class GoodsRepositoryImp implements GoodsRepository {
  final SqliteService sqliteService;

  GoodsRepositoryImp({required this.sqliteService});

  @override
  Future<Either<Failure, int>> addCategory(CategoryEntity categoryEntity) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> addItem(ItemEntity itemEntity) {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final objects = await sqliteService.getCategories();
      return Right(objects);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> getItems(int categoryId) {
    // TODO: implement getItems
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> removeCategory(CategoryEntity categoryEntity) {
    // TODO: implement removeCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> removeItem(ItemEntity itemEntity) {
    // TODO: implement removeItem
    throw UnimplementedError();
  }
}
