import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/item_entity.dart';
import 'package:pos_sqlite/business/repositories/goods_repository.dart';
import 'package:pos_sqlite/core/error/failure.dart';

class GetItems {
  final GoodsRepository goodsRepository;

  GetItems(this.goodsRepository);

  Future<Either<Failure, List<ItemEntity>>> call(
      int categoryId) async {
    return await goodsRepository.getItems(categoryId);
  }
}

class AddItem {
  final GoodsRepository goodsRepository;

  AddItem(this.goodsRepository);

  Future<Either<Failure, int>> call(ItemEntity item) async {
    return await goodsRepository.addItem(item);
  }
}

class RemoveItem {
  final GoodsRepository goodsRepository;

  RemoveItem(this.goodsRepository);

  Future<Either<Failure, int>> call(ItemEntity item) async {
    return await goodsRepository.removeItem(item);
  }
}
