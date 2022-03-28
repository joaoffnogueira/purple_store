import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/components/app_drawer.dart';
import 'package:purple_store/components/product_item.dart';
import 'package:purple_store/models/product_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductList>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Gerenciar Produtos'),
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemCount,
            itemBuilder: ((context, index) => Column(
                  children: [
                    ProductItem(
                      product: products.itens[index],
                    ),
                    Divider(),
                  ],
                )),
          ),
        ));
  }
}
