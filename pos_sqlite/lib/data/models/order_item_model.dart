import 'package:pos_sqlite/business/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required id,
    required orderId,
    required count,
  }) : super(
          id: id,
          orderId: orderId,
          count: count,
        );

  factory OrderItemModel.fromMap(Map<String, dynamic> item) {
    return OrderItemModel(
      id: item['id'],
      orderId: item['orderId'],
      count: item['count'],
    );
  }

  factory OrderItemModel.fromEntity(OrderItemEntity orderItem) {
    return OrderItemModel(
      id: orderItem.id,
      orderId: orderItem.orderId,
      count: orderItem.count,
    );
  }

  Map<String, Object> toMap() {
    return {
      'orderId': orderId,
      'count': count,
    };
  }
}
