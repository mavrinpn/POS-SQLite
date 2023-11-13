import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/order_entity.dart';
import 'package:pos_sqlite/business/entities/order_item_entity.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/core/error/failure.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<TableEntity>>> getTables();
  Future<Either<Failure, int>> addTable(TableEntity table);
  Future<Either<Failure, int>> removeTable(TableEntity table);
  Future<Either<Failure, int>> addOrder(OrderEntity order);
  Future<Either<Failure, int>> removeOrder(OrderEntity order);
  Future<Either<Failure, List<OrderEntity>>> getTableOrders(int tableId);
  Future<Either<Failure, List<OrderEntity>>> getAllOrders();
  Future<Either<Failure, List<OrderItemEntity>>> getOrderItems(int orderId);
  Future<Either<Failure, int>> addOrderItem(OrderItemEntity item);
  Future<Either<Failure, int>> updateOrderItem(OrderItemEntity item);
  Future<Either<Failure, int>> removeOrderItem(OrderItemEntity item);
}
