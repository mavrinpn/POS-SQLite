import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sqlite/business/entities/item_entity.dart';
import 'package:pos_sqlite/business/usecases/items_usecases.dart';
import 'package:pos_sqlite/core/error/failure.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final GetItems getItems;
  final AddItem addItem;
  final RemoveItem removeItem;

  ItemsBloc({
    required this.getItems,
    required this.addItem,
    required this.removeItem,
  }) : super(ItemsInitial()) {
    on<LoadItemsEvent>((event, emit) async {
      emit(ItemsLoading());
      await loadCategories(event, emit);
    });

    on<AddItemEvent>((event, emit) async {
      final result = await addItem(event.item);
      failureOrDone(result, emit, event.item.categoryId);
    });

    on<RemoveItemEvent>((event, emit) async {
      final result = await removeItem(event.item);
      failureOrDone(result, emit, event.item.categoryId);
    });
  }

  Future<void> loadCategories(event, emit) async {
    final failureOrItems = await getItems(event.categoryId);
    failureOrItems.fold((failure) {
      emit(const ItemsError(message: 'Error'));
    }, (items) {
      emit(ItemsLoaded(
        items: items,
      ));
    });
  }

  void failureOrDone(Either<Failure, int> failureOrDone, emit, int categoryId) {
    failureOrDone.fold((failure) {
      emit(const ItemsError(message: 'Error'));
    }, (_) {
      if (state is ItemsLoaded) {
        add(LoadItemsEvent(categoryId: categoryId));
      }
    });
  }
}
