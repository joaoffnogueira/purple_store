import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/components/app_drawer.dart';
import 'package:purple_store/components/order_widget.dart';
import 'package:purple_store/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.ordersCount,
        itemBuilder: (context, index) {
          return OrderWidget(
            order: orders.orders[index],
          );
        },
      ),
    );
  }
}
