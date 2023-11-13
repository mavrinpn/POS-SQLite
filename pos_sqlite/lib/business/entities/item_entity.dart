import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final int id;
  final int categoryId;
  final String title;
  final double cost;
  final String image;

  const ItemEntity({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.cost,
    required this.image,
  });

  @override
  List<Object?> get props => [id, categoryId, title, cost, image];
}
