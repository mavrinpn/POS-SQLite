part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object?> get props => [];
}

class ItemsInitial extends ItemsState {
  @override
  List<Object?> get props => [];
}

class ItemsLoading extends ItemsState {
  @override
  List<Object?> get props => [];
}

class ItemsLoaded extends ItemsState {
  final List<ItemEntity> items;

  const ItemsLoaded({
    required this.items,
  });

  @override
  List<Object?> get props => [items];
}

class ItemsError extends ItemsState {
  final String message;

  const ItemsError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
