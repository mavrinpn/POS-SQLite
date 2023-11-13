import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sqlite/business/entities/order_entity.dart';
import 'package:pos_sqlite/presentation/blocs/order_items/order_items_bloc.dart';

class ClientPage extends StatefulWidget {
  final OrderEntity order;
  const ClientPage({
    required this.order,
    super.key,
  });

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    context
        .read<OrderItemsBloc>()
        .add(LoadOrderItemsEvent(orderId: widget.order.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.client),
      ),
      body: BlocBuilder<OrderItemsBloc, OrderItemsState>(
        builder: (contex, state) {
          if (state is OrderItemsLoaded) {
            final items = state.orderItems;
            if (items.isEmpty) {
              return const Center(
                child: Text('Добавьте товары'),
              );
            } else {
              //TODO вывод товаров
                //TODO вывод заказа
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Card(
                    child: ListTile(
                      title: Text('${item.id}'),
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
    );
  }
}
