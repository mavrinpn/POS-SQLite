part of 'tables_bloc.dart';

abstract class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object?> get props => [];
}

class LoadTablesEvent extends TablesEvent {
  const LoadTablesEvent();

  @override
  List<Object?> get props => [];
}

class AddTablesEvent extends TablesEvent {
  final TableEntity table;

  const AddTablesEvent({required this.table});

  @override
  List<Object?> get props => [table];
}

class RemoveTableEvent extends TablesEvent {
  final TableEntity table;

  const RemoveTableEvent({required this.table});

  @override
  List<Object?> get props => [table];
}
