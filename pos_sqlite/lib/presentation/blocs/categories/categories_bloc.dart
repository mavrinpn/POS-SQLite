import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sqlite/business/entities/category_entity.dart';
import 'package:pos_sqlite/business/usecases/goods_usecases.dart';
import 'package:pos_sqlite/core/error/failure.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;
  final AddCategory addCategory;

  CategoriesBloc({
    required this.getCategories,
    required this.addCategory,
  }) : super(CategoriesInitial()) {
    on<LoadCategoriesEvent>((event, emit) async {
      emit(CategoriesLoading());
      await loadCategories(event, emit);
    });

    on<AddCategoryEvent>((event, emit) async {
      final result = await addCategory(event.category);
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

  void failureOrDone(Either<Failure, void> failureOrDone, emit) {
    failureOrDone.fold((failure) {
      emit(const CategoriesError(message: 'Error'));
    }, (_) {
      if (state is CategoriesLoaded) {
        add(const LoadCategoriesEvent());
      }
    });
  }
}
