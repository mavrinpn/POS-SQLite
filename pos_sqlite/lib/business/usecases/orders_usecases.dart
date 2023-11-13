import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/order_entity.dart';
import 'package:pos_sqlite/business/entities/order_item_entity.dart';
import 'package:pos_sqlite/business/repositories/orders_repository.dart';
import 'package:pos_sqlite/core/error/failure.dart';

class GetAllOrders {
  final OrdersRepository ordersRepository;

  GetAllOrders(this.ordersRepository);

  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await ordersRepository.getAllOrders();
  }
}

class GetTableOrders {
  final OrdersRepository ordersRepository;

  GetTableOrders(this.ordersRepository);

  Future<Either<Failure, List<OrderEntity>>> call(int tableId) async {
    return await ordersRepository.getTableOrders(tableId);
  }
}

class AddOrder {
  final OrdersRepository ordersRepository;

  AddOrder(this.ordersRepository);

  Future<Either<Failure, int>> call(OrderEntity item) async {
    return await ordersRepository.addOrder(item);
  }
}

class RemoveOrder {
  final OrdersRepository ordersRepository;

  RemoveOrder(this.ordersRepository);

  Future<Either<Failure, int>> call(OrderEntity item) async {
    return await ordersRepository.removeOrder(item);
  }
}

class GetOrderItems {
  final OrdersRepository ordersRepository;

  GetOrderItems(this.ordersRepository);

  Future<Either<Failure, List<OrderItemEntity>>> call(int orderId) async {
    return await ordersRepository.getOrderItems(orderId);
  }
}

class AddOrderItem {
  final OrdersRepository ordersRepository;

  AddOrderItem(this.ordersRepository);

  Future<Either<Failure, int>> call(OrderItemEntity item) async {
    return await ordersRepository.addOrderItem(item);
  }
}

class UpdateOrderItem {
  final OrdersRepository ordersRepository;

  UpdateOrderItem(this.ordersRepository);

  Future<Either<Failure, int>> call(OrderItemEntity item) async {
    return await ordersRepository.updateOrderItem(item);
  }
}

class RemoveOrderItem {
  final OrdersRepository ordersRepository;

  RemoveOrderItem(this.ordersRepository);

  Future<Either<Failure, int>> call(OrderItemEntity item) async {
    return await ordersRepository.removeOrderItem(item);
  }
}
