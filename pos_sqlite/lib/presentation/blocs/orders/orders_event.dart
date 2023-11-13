part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

class LoadTableOrdersEvent extends OrdersEvent {
  final int tableId;
  const LoadTableOrdersEvent({required this.tableId});

  @override
  List<Object?> get props => [tableId];
}

class LoadAllOrdersEvent extends OrdersEvent {
  const LoadAllOrdersEvent();

  @override
  List<Object?> get props => [];
}

class AddOrderEvent extends OrdersEvent {
  final OrderEntity order;

  const AddOrderEvent({required this.order});

  @override
  List<Object?> get props => [order];
}

class RemoveOrderEvent extends OrdersEvent {
  final OrderEntity order;

  const RemoveOrderEvent({required this.order});

  @override
  List<Object?> get props => [order];
}
