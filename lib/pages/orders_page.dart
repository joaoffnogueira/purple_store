import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/components/app_drawer.dart';
import 'package:purple_store/components/order_widget.dart';
import 'package:purple_store/models/order_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(context, listen: false).loadOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
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
