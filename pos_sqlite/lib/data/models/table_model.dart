import 'package:pos_sqlite/business/entities/table_entity.dart';

class TableModel extends TableEntity {
  const TableModel({
    required id,
    required title,
  }) : super(
          id: id,
          title: title,
        );

  factory TableModel.fromMap(Map<String, dynamic> item) {
    return TableModel(
      id: item['id'],
      title: item['title'],
    );
  }

  factory TableModel.fromEntity(TableEntity table) {
    return TableModel(id: table.id, title: table.title);
  }

  Map<String, Object> toMap() {
    return {
      'title': title,
    };
  }
}
