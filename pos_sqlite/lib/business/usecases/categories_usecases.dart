import 'package:dartz/dartz.dart';
import 'package:pos_sqlite/business/entities/category_entity.dart';
import 'package:pos_sqlite/business/repositories/goods_repository.dart';
import 'package:pos_sqlite/core/error/failure.dart';

class GetCategories {
  final GoodsRepository goodsRepository;

  GetCategories(this.goodsRepository);

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await goodsRepository.getCategories();
  }
}

class AddCategory {
  final GoodsRepository goodsRepository;

  AddCategory(this.goodsRepository);

  Future<Either<Failure, int>> call(CategoryEntity category) async {
    return await goodsRepository.addCategory(category);
  }
}

class RemoveCategory {
  final GoodsRepository goodsRepository;

  RemoveCategory(this.goodsRepository);

  Future<Either<Failure, int>> call(CategoryEntity category) async {
    return await goodsRepository.removeCategory(category);
  }
}
