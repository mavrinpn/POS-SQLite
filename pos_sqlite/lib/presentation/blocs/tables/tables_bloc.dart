import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sqlite/business/entities/category_entity.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/business/usecases/categories_usecases.dart';
import 'package:pos_sqlite/core/error/failure.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  final GetCategories getCategories;
  final AddCategory addCategory;
  final RemoveCategory removeCategory;

  TablesBloc({
    required this.getCategories,
    required this.addCategory,
    required this.removeCategory,
  }) : super(TablesInitial()) {
    on<LoadTablesEvent>((event, emit) async {
      emit(TablesLoading());
      await loadCategories(event, emit);
    });

    on<AddCategoryEvent>((event, emit) async {
      final result = await addCategory(event.category);
      failureOrDone(result, emit);
    });

    on<RemoveCategoryEvent>((event, emit) async {
      final result = await removeCategory(event.category);
      failureOrDone(result, emit);
    });
  }

  Future<void> loadCategories(event, emit) async {
    final failureOrCategories = await getCategories();
    failureOrCategories.fold((failure) {
      emit(const CategoriesError(message: 'Error'));
    }, (categories) {
      emit(CategoriesLoaded(
        categories: categories,
      ));
    });
  }

  void failureOrDone(Either<Failure, int> failureOrDone, emit) {
    failureOrDone.fold((failure) {
      emit(const CategoriesError(message: 'Error'));
    }, (_) {
      if (state is CategoriesLoaded) {
        add(const LoadCategoriesEvent());
      }
    });
  }
}
