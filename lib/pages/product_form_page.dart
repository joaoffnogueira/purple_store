import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageController.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _imageController.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Produtos'),
        ),
        body: Form(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: false,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                autocorrect: false,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                autocorrect: false,
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
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: false,
                    ),
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
                                child: Image.network(_imageController.text),
                                fit: BoxFit.cover,
                              )),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Salvar'),
              ),
            ],
          ),
        ));
  }
}
