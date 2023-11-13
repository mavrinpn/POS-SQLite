import 'package:equatable/equatable.dart';

class TableEntity extends Equatable {
  final int id;
  final String title;

  const TableEntity({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}
