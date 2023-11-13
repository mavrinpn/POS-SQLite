import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/business/repositories/orders_repository.dart';
import 'package:pos_sqlite/core/error/failure.dart';

class GetTables {
  final OrdersRepository ordersRepository;

  GetTables(this.ordersRepository);

  Future<Either<Failure, List<TableEntity>>> call() async {
    return await ordersRepository.getTables();
  }
}

class AddTable {
  final OrdersRepository ordersRepository;

  AddTable(this.ordersRepository);

  Future<Either<Failure, int>> call(TableEntity item) async {
    return await ordersRepository.addTable(item);
  }
}

class RemoveTable {
  final OrdersRepository ordersRepository;

  RemoveTable(this.ordersRepository);

  Future<Either<Failure, int>> call(TableEntity item) async {
    return await ordersRepository.removeTable(item);
  }
}
