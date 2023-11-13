import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/item_entity.dart';
import 'package:pos_sqlite/business/entities/order_entity.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/core/error/failure.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<TableEntity>>> getTables();
  Future<void> addTable(TableEntity tableEntity);
  Future<void> removeTable(TableEntity tableEntity);
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<void> addItem({
    required ItemEntity item,
    required OrderEntity order,
  });
  Future<void> removeItem({
    required ItemEntity item,
    required OrderEntity order,
  });
}
