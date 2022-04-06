import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/models/auth.dart';
import 'package:purple_store/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text('Bem vindo!'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Produtos'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
          },
        ),
        Divider(),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Pedidos'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
          },
        ),
        Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Gerenciar Produtos'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
          },
        ),
        Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Sair'),
          onTap: () {
            Provider.of<Auth>(
              context,
              listen: false,
            ).logout();
            Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
          },
        ),
      ]),
    );
  }
}
