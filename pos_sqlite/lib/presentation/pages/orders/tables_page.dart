import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/presentation/blocs/tables/tables_bloc.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({super.key});

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  @override
  Widget build(BuildContext context) {
    context.read<TablesBloc>().add(const LoadTablesEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Столы'),
      ),
      body: BlocBuilder<TablesBloc, TablesState>(
        builder: (contex, state) {
          if (state is TablesLoaded) {
            final tables = state.tables;

            if (tables.isEmpty) {
              return const Center(
                child: Text('Добавьте стол'),
              );
            } else {
              return ListView.builder(
                itemCount: tables.length,
                itemBuilder: (context, index) {
                  final table = tables[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.go(
                          '/orders/table_orders',
                          extra: table,
                        );
                      },
                      title: Text(table.title),
                      subtitle: Text('${table.id}'),
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
          'Добавить стол',
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
              onPressed: () {
                final formValidator = categoryFormKey.currentState!.validate();
                if (formValidator) {
                  final table = TableEntity(
                    id: 0,
                    title: titleTextController.text,
                  );
                  context.read<TablesBloc>().add(AddTablesEvent(table: table));
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
