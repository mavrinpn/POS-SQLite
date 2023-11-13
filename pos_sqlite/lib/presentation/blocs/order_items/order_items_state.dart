part of 'order_items_bloc.dart';

abstract class OrderItemsState extends Equatable {
  const OrderItemsState();

  @override
  List<Object?> get props => [];
}

class OrderItemsInitial extends OrderItemsState {
  @override
  List<Object?> get props => [];
}

class OrderItemsLoading extends OrderItemsState {
  @override
  List<Object?> get props => [];
}

class OrderItemsLoaded extends OrderItemsState {
  final List<OrderItemEntity> orderItems;

  const OrderItemsLoaded({
    required this.orderItems,
  });

  @override
  List<Object?> get props => [orderItems];
}

class OrderItemsError extends OrderItemsState {
  final String message;

  const OrderItemsError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
