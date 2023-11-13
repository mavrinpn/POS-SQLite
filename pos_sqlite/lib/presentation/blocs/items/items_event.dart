part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object?> get props => [];
}

class LoadItemsEvent extends ItemsEvent {
  final int categoryId;

  const LoadItemsEvent({required this.categoryId});

  @override
  List<Object?> get props => [];
}

class AddItemEvent extends ItemsEvent {
  final ItemEntity item;

  const AddItemEvent({required this.item});

  @override
  List<Object?> get props => [item];
}

class RemoveItemEvent extends ItemsEvent {
  final ItemEntity item;

  const RemoveItemEvent({required this.item});

  @override
  List<Object?> get props => [item];
}
