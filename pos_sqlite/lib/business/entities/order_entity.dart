import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final int id;
  final int tableId;
  final String client;

  const OrderEntity({
    required this.id,
    required this.tableId,
    required this.client,
  });

  @override
  List<Object?> get props => [id, tableId, client];
}
