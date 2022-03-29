import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/models/product_list.dart';
import 'package:purple_store/models/products.dart';
import 'package:purple_store/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
            },
            icon: Icon(Icons.edit),
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Excluir Produto'),
                        content: Text(
                            'Tem certeza que deseja excluir o produto ${product.title}?'),
                        actions: [
                          TextButton(
                            child: Text('Não'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text('Sim, excluir'),
                            onPressed: () {
                              Provider.of<ProductList>(context, listen: false)
                                  .removeProduct(product);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
            },
            icon: Icon(Icons.delete),
            color: Theme.of(context).colorScheme.error,
          ),
        ]),
      ),
    );
  }
}
