import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/category_entity.dart';
import 'package:pos_sqlite/business/entities/item_entity.dart';
import 'package:pos_sqlite/business/repositories/goods_repository.dart';
import 'package:pos_sqlite/core/error/failure.dart';
import 'package:pos_sqlite/data/models/category_model.dart';
import 'package:pos_sqlite/data/models/item_model.dart';
import 'package:pos_sqlite/data/services/sqlite_service.dart';
import 'package:sqflite/sqlite_api.dart';

class GoodsRepositoryImp implements GoodsRepository {
  final SqliteService sqliteService;

  GoodsRepositoryImp({required this.sqliteService});

  @override
  Future<Either<Failure, int>> addCategory(CategoryEntity category) async {
    try {
      final result = await sqliteService
          .createCategory(CategoryModel.fromEntity(category));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addItem(ItemEntity item) async {
    try {
      final result = await sqliteService.createItem(ItemModel.fromEntity(item));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
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
  Future<Either<Failure, List<ItemEntity>>> getItems(int categoryId) async {
    try {
      final objects = await sqliteService.getItems(categoryId);
      return Right(objects);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> removeCategory(CategoryEntity category) async {
    try {
      final result = await sqliteService
          .deleteCategory(CategoryModel.fromEntity(category));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> removeItem(ItemEntity item) async {
    try {
      final result = await sqliteService.deleteItem(ItemModel.fromEntity(item));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
