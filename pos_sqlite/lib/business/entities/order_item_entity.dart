import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final int id;
  final int orderId;
  final int count;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.count,
  });

  @override
  List<Object?> get props => [id, orderId, count];
}
