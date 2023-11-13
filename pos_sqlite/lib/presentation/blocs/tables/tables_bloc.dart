import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/business/usecases/tables_usecases.dart';
import 'package:pos_sqlite/core/error/failure.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  final GetTables getTables;
  final AddTable addTable;
  final RemoveTable removeTable;

  TablesBloc({
    required this.getTables,
    required this.addTable,
    required this.removeTable,
  }) : super(TablesInitial()) {
    on<LoadTablesEvent>((event, emit) async {
      emit(TablesLoading());
      await loadTables(event, emit);
    });

    on<AddTablesEvent>((event, emit) async {
      final result = await addTable(event.table);
      failureOrDone(result, emit);
    });

    on<RemoveTableEvent>((event, emit) async {
      final result = await removeTable(event.table);
      failureOrDone(result, emit);
    });
  }

  Future<void> loadTables(event, emit) async {
    final failureOrCategories = await getTables();
    failureOrCategories.fold((failure) {
      emit(const TablesError(message: 'Error'));
    }, (tables) {
      emit(TablesLoaded(
        tables: tables,
      ));
    });
  }

  void failureOrDone(Either<Failure, int> failureOrDone, emit) {
    failureOrDone.fold((failure) {
      emit(const TablesError(message: 'Error'));
    }, (_) {
      if (state is TablesLoaded) {
        add(const LoadTablesEvent());
      }
    });
  }
}
