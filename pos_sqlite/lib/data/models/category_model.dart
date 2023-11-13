import 'package:pos_sqlite/business/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({required id, required title})
      : super(id: id, title: title);

  factory CategoryModel.fromMap(Map<String, dynamic> item) {
    return CategoryModel(
      id: item['id'],
      title: item['title'],
    );
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
