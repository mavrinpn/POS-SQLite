import 'package:pos_sqlite/business/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    required id,
    required categoryId,
    required title,
    required cost,
  }) : super(
          id: id,
          categoryId: categoryId,
          title: title,
          cost: cost,
        );

  factory ItemModel.fromMap(Map<String, dynamic> item) {
    return ItemModel(
      id: item['id'],
      categoryId: item['categoryId'],
      title: item['title'],
      cost: item['cost'],
    );
  }

  factory ItemModel.fromEntity(ItemEntity item) {
    return ItemModel(
      id: item.id,
      categoryId: item.categoryId,
      title: item.title,
      cost: item.cost,
    );
  }

  Map<String, Object> toMap() {
    return {
      'categoryId': categoryId,
      'title': title,
      'cost': cost,
    };
  }
}
