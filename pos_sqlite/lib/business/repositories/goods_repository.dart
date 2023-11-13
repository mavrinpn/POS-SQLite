import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/category_entity.dart';
import 'package:pos_sqlite/business/entities/item_entity.dart';
import 'package:pos_sqlite/core/error/failure.dart';

abstract class GoodsRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, int>> addCategory(CategoryEntity categoryEntity);
  Future<Either<Failure, int>> removeCategory(CategoryEntity categoryEntity);
  Future<Either<Failure, List<ItemEntity>>> getItems(int categoryId);
  Future<Either<Failure, void>> addItem(ItemEntity itemEntity);
  Future<Either<Failure, void>> removeItem(ItemEntity itemEntity);
}
