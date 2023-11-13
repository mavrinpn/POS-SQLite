part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoriesEvent extends CategoriesEvent {
  const LoadCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class AddCategoryEvent extends CategoriesEvent {
  final CategoryEntity category;

  const AddCategoryEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class RemoveCategoryEvent extends CategoriesEvent {
  final CategoryEntity category;

  const RemoveCategoryEvent({required this.category});

  @override
  List<Object?> get props => [category];
}
