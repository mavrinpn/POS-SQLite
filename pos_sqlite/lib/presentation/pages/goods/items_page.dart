import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sqlite/business/entities/category_entity.dart';
import 'package:pos_sqlite/business/entities/item_entity.dart';
import 'package:pos_sqlite/presentation/blocs/categories/categories_bloc.dart';
import 'package:pos_sqlite/presentation/blocs/items/items_bloc.dart';

class ItemsPage extends StatefulWidget {
  final CategoryEntity category;
  const ItemsPage({
    required this.category,
    super.key,
  });

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    context
        .read<ItemsBloc>()
        .add(LoadItemsEvent(categoryId: widget.category.id));

    return Scaffold(
      appBar: AppBar(
        title: Text('Категория ${widget.category.title}'),
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<CategoriesBloc>()
                  .add(RemoveCategoryEvent(category: widget.category));
              Navigator.pop(context);
            },
            tooltip: 'Удалить категрию',
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (contex, state) {
          if (state is ItemsLoaded) {
            final items = state.items;
            if (items.isEmpty) {
              return const Center(
                child: Text('Добавьте товары'),
              );
            } else {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Card(
                    child: ListTile(
                      onTap: () {},
                      title: Text(item.title),
                      subtitle: Text('${item.id}'),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text('Загрузка...'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void addDialog(BuildContext context) {
    final categoryFormKey = GlobalKey<FormState>();
    final titleTextController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.only(left: 30, right: 30),
        title: const Text(
          'Добавить товар',
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
              onPressed: () {
                final formValidator = categoryFormKey.currentState!.validate();
                if (formValidator) {
                  final item = ItemEntity(
                    id: 0,
                    categoryId: widget.category.id,
                    title: titleTextController.text,
                    cost: 200,
                    //TODO cost
                  );
                  context.read<ItemsBloc>().add(AddItemEvent(item: item));
                  Navigator.pop(context);
                }
              },
              child: const Text('Добавить')),
        ],
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            width: double.maxFinite,
            child: Form(
              key: categoryFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleTextController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      errorText: null,
                      labelText: 'Название',
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
