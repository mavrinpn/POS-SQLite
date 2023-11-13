part of 'order_items_bloc.dart';

abstract class OrderItemsEvent extends Equatable {
  const OrderItemsEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrderItemsEvent extends OrderItemsEvent {
  final int orderId;
  const LoadOrderItemsEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class AddOrderItemEvent extends OrderItemsEvent {
  final OrderItemEntity orderItem;

  const AddOrderItemEvent({required this.orderItem});

  @override
  List<Object?> get props => [orderItem];
}

class RemoveOrderItemEvent extends OrderItemsEvent {
  final OrderItemEntity orderItem;

  const RemoveOrderItemEvent({required this.orderItem});

  @override
  List<Object?> get props => [orderItem];
}
