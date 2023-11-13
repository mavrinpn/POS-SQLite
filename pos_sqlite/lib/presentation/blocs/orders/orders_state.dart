part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersLoading extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;

  const OrdersLoaded({
    required this.orders,
  });

  @override
  List<Object?> get props => [orders];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
