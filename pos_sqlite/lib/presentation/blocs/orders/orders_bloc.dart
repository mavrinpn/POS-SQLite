import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sqlite/business/entities/order_entity.dart';
import 'package:pos_sqlite/business/usecases/orders_usecases.dart';
import 'package:pos_sqlite/core/error/failure.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetTableOrders getTableOrders;
  final GetAllOrders getAllOrders;
  final AddOrder addOrder;
  final RemoveOrder removeOrder;

  OrdersBloc({
    required this.getTableOrders,
    required this.getAllOrders,
    required this.addOrder,
    required this.removeOrder,
  }) : super(OrdersInitial()) {
    on<LoadTableOrdersEvent>((event, emit) async {
      emit(OrdersLoading());
      final failureOrCategories = await getTableOrders(event.tableId);
      failureOrCategories.fold((failure) {
        emit(const OrdersError(message: 'Error'));
      }, (orders) {
        emit(OrdersLoaded(
          orders: orders,
        ));
      });
    });

    on<LoadAllOrdersEvent>((event, emit) async {
      emit(OrdersLoading());
      final failureOrCategories = await getAllOrders();
      failureOrCategories.fold((failure) {
        emit(const OrdersError(message: 'Error'));
      }, (orders) {
        emit(OrdersLoaded(
          orders: orders,
        ));
      });
    });

    on<AddOrderEvent>((event, emit) async {
      final result = await addOrder(event.order);
      failureOrDone(result, emit, event.order.tableId);
    });

    on<RemoveOrderEvent>((event, emit) async {
      final result = await removeOrder(event.order);
      failureOrDone(result, emit, event.order.tableId);
    });
  }

  void failureOrDone(Either<Failure, int> failureOrDone, emit, int tableId) {
    failureOrDone.fold((failure) {
      emit(const OrdersError(message: 'Error'));
    }, (_) {
      if (state is OrdersLoaded) {
        add(LoadTableOrdersEvent(tableId: tableId));
      }
    });
  }
}
