import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_sqlite/business/entities/category_entity.dart';
import 'package:pos_sqlite/presentation/blocs/categories/categories_bloc.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (contex, state) {
          if (state is CategoriesLoaded) {
            final categories = state.categories;

            if (categories.isEmpty) {
              return const Center(
                child: Text('Добавьте категорию'),
              );
            } else {
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.go(
                          '/goods/category',
                          extra: category,
                        );
                      },
                      title: Text(category.title),
                      subtitle: Text('${category.id}'),
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
        onPressed: () => addCategoryDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void addCategoryDialog(BuildContext context) {
    final categoryFormKey = GlobalKey<FormState>();
    final titleTextController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.only(left: 30, right: 30),
        title: const Text(
          'Добавить категорию',
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
              onPressed: () {
                final formValidator = categoryFormKey.currentState!.validate();
                if (formValidator) {
                  final category = CategoryEntity(
                    id: 0,
                    title: titleTextController.text,
                  );
                  context
                      .read<CategoriesBloc>()
                      .add(AddCategoryEvent(category: category));
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
