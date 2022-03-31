import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/models/product_list.dart';
import 'package:purple_store/models/products.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageController.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty &&
        ModalRoute.of(context)?.settings.arguments != null) {
      final product = ModalRoute.of(context)?.settings.arguments as Product;
      if (product != null) {
        _formData['id'] = product.id;
        _formData['name'] = product.title;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;
        _imageController.text = product.imageUrl;
      } else {
        _formData['price'] = '';
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageController.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    setState(() => _isLoading = true);

    Provider.of<ProductList>(context, listen: false)
        .saveProduct(_formData)
        .then((value) {
      setState(() => _isLoading = true);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Produtos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _submitForm,
            ),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (name) {
                        if (name!.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        if (name.trim().length < 3) {
                          return 'Nome deve ter pelo menos 3 caracteres';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                      ),
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      autocorrect: true,
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (description) {
                        if (description!.trim().isEmpty) {
                          return 'Descrição é obrigatória';
                        }
                        if (description.trim().length < 10) {
                          return 'Descrição deve ter pelo menos 10 caracteres';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Preço',
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      autocorrect: false,
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price?.trim() ?? '';
                        final price = double.tryParse(priceString) ?? -1;
                        if (price <= 0) {
                          return 'Preço inválido';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'URL da imagem',
                              ),
                              controller: _imageController,
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              onSaved: (imageUrl) =>
                                  _formData['imageUrl'] = imageUrl ?? '',
                              onFieldSubmitted: (_) => _submitForm(),
                              validator: (imageUrl) {
                                if (!isValidImageUrl(imageUrl!)) {
                                  return 'URL inválida';
                                }
                                return null;
                              }),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Center(
                              child: _imageController.text.isEmpty
                                  ? Text('Informe a URL da imagem')
                                  : FittedBox(
                                      child:
                                          Image.network(_imageController.text),
                                      fit: BoxFit.cover,
                                      clipBehavior: Clip.hardEdge,
                                    )),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }
}
