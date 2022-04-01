import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/components/app_drawer.dart';
import 'package:purple_store/components/order_widget.dart';
import 'package:purple_store/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<OrderList>(context, listen: false).loadOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return const Center(
                child: Text('Ocorreu um erro ao carregar os pedidos'),
              );
            } else {
              return Consumer<OrderList>(
                builder: (context, orders, child) => ListView.builder(
                  itemCount: orders.ordersCount,
                  itemBuilder: (context, index) {
                    return OrderWidget(
                      order: orders.orders[index],
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
