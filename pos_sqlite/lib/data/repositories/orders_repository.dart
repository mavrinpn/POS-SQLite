import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/order_entity.dart';
import 'package:pos_sqlite/business/entities/order_item_entity.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/business/repositories/orders_repository.dart';
import 'package:pos_sqlite/core/error/failure.dart';
import 'package:pos_sqlite/data/models/order_item_model.dart';
import 'package:pos_sqlite/data/models/order_model.dart';
import 'package:pos_sqlite/data/models/table_model.dart';
import 'package:pos_sqlite/data/services/sqlite_service.dart';
import 'package:sqflite/sqlite_api.dart';

class OrdersRepositoryImp implements OrdersRepository {
  final SqliteService sqliteService;

  OrdersRepositoryImp({required this.sqliteService});

  @override
  Future<Either<Failure, int>> addTable(TableEntity table) async {
    try {
      final result =
          await sqliteService.createTable(TableModel.fromEntity(table));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getTableOrders(int tableId) async {
    try {
      final objects = await sqliteService.getTableOrders(tableId);
      return Right(objects);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getAllOrders() async {
    try {
      final objects = await sqliteService.getAllOrders();
      return Right(objects);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<TableEntity>>> getTables() async {
    try {
      final objects = await sqliteService.getTables();
      return Right(objects);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> removeTable(TableEntity table) async {
    try {
      final result =
          await sqliteService.deleteTable(TableModel.fromEntity(table));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addOrder(OrderEntity order) async {
    try {
      final result =
          await sqliteService.createOrder(OrderModel.fromEntity(order));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> removeOrder(OrderEntity order) async {
    try {
      final result =
          await sqliteService.deleteOrder(OrderModel.fromEntity(order));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderItemEntity>>> getOrderItems(
      int orderId) async {
    try {
      final result = await sqliteService.getOrderItems(orderId);
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addOrderItem(OrderItemEntity item) async {
    try {
      final result =
          await sqliteService.createOrderItem(OrderItemModel.fromEntity(item));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> removeOrderItem(OrderItemEntity item) async {
    try {
      final result =
          await sqliteService.deleteOrderItem(OrderItemModel.fromEntity(item));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> updateOrderItem(OrderItemEntity item) async {
    try {
      final result =
          await sqliteService.updateOrderItem(OrderItemModel.fromEntity(item));
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
