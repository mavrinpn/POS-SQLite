import 'package:pos_sqlite/business/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required id,
    required tableId,
    required client,
  }) : super(
          id: id,
          tableId: tableId,
          client: client,
        );

  factory OrderModel.fromMap(Map<String, dynamic> item) {
    return OrderModel(
      id: item['id'],
      tableId: item['tableId'],
      client: item['client'],
    );
  }

  factory OrderModel.fromEntity(OrderEntity order) {
    return OrderModel(
      id: order.id,
      tableId: order.tableId,
      client: order.client,
    );
  }

  Map<String, Object> toMap() {
    return {
      'tableId': tableId,
      'client': client,
    };
  }
}
