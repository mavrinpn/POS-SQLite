import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sqlite/business/entities/order_item_entity.dart';
import 'package:pos_sqlite/business/usecases/orders_usecases.dart';
import 'package:pos_sqlite/core/error/failure.dart';

part 'order_items_event.dart';
part 'order_items_state.dart';

class OrderItemsBloc extends Bloc<OrderItemsEvent, OrderItemsState> {
  final GetOrderItems getOrderItems;
  final AddOrderItem addOrderItem;
  final UpdateOrderItem updateOrderItem;
  final RemoveOrderItem removeOrderItem;

  OrderItemsBloc({
    required this.getOrderItems,
    required this.addOrderItem,
    required this.updateOrderItem,
    required this.removeOrderItem,
  }) : super(OrderItemsInitial()) {
    on<LoadOrderItemsEvent>((event, emit) async {
      emit(OrderItemsLoading());
      final failureOrCategories = await getOrderItems(event.orderId);
      failureOrCategories.fold((failure) {
        emit(const OrderItemsError(message: 'Error'));
      }, (orderItems) {
        emit(OrderItemsLoaded(
          orderItems: orderItems,
        ));
      });
    });

    on<AddOrderItemEvent>((event, emit) async {
      final result = await addOrderItem(event.orderItem);
      failureOrDone(result, emit, event.orderItem.orderId);
    });

    on<RemoveOrderItemEvent>((event, emit) async {
      final result = await removeOrderItem(event.orderItem);
      failureOrDone(result, emit, event.orderItem.orderId);
    });
  }

  void failureOrDone(Either<Failure, int> failureOrDone, emit, int orderId) {
    failureOrDone.fold((failure) {
      emit(const OrderItemsError(message: 'Error'));
    }, (_) {
      if (state is OrderItemsLoaded) {
        add(LoadOrderItemsEvent(orderId: orderId));
      }
    });
  }
}
