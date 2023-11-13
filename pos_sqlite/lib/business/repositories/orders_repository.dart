import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/item_entity.dart';
import 'package:pos_sqlite/business/entities/order_entity.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/core/error/failure.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<TableEntity>>> getTables();
  Future<Either<Failure, int>> addTable(TableEntity tableEntity);
  Future<Either<Failure, int>> removeTable(TableEntity tableEntity);
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, int>> addItem({
    required ItemEntity item,
    required OrderEntity order,
  });
  Future<Either<Failure, int>> removeItem({
    required ItemEntity item,
    required OrderEntity order,
  });
}
