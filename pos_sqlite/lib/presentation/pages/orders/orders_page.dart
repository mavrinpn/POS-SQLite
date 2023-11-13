import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_sqlite/business/entities/order_entity.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/presentation/blocs/orders/orders_bloc.dart';

class OrdersPage extends StatefulWidget {
  final TableEntity? table;
  const OrdersPage({
    this.table,
    super.key,
  });

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    context.read<OrdersBloc>().add(widget.table != null
        ? LoadTableOrdersEvent(tableId: widget.table!.id)
        : const LoadAllOrdersEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.table != null ? widget.table!.title : 'Все заказы'),
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (contex, state) {
          if (state is OrdersLoaded) {
            final items = state.orders;
            if (items.isEmpty) {
              return const Center(
                child: Text('Добавьте заказ'),
              );
            } else {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        contex.go(
                          '/orders/order',
                          extra: item,
                        );
                      },
                      title: Text(item.client),
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
          'Добавить заказ',
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
              onPressed: () {
                final formValidator = categoryFormKey.currentState!.validate();
                if (formValidator) {
                  final item = OrderEntity(
                    id: 0,
                    tableId: widget.table != null ? widget.table!.id : 0,
                    client: titleTextController.text,
                  );
                  context.read<OrdersBloc>().add(AddOrderEvent(order: item));
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
                      labelText: 'Клиент',
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
