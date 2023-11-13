part of 'tables_bloc.dart';

abstract class TablesState extends Equatable {
  const TablesState();

  @override
  List<Object?> get props => [];
}

class TablesInitial extends TablesState {
  @override
  List<Object?> get props => [];
}

class TablesLoading extends TablesState {
  @override
  List<Object?> get props => [];
}

class TablesLoaded extends TablesState {
  final List<CategoryEntity> tables;

  const TablesLoaded({
    required this.tables,
  });

  @override
  List<Object?> get props => [tables];
}

class CategoriesError extends TablesState {
  final String message;

  const CategoriesError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
