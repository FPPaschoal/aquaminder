import 'package:flutter/material.dart';
import 'package:AquaMinder/Entidades/Item.dart';
import 'package:AquaMinder/simula_bd.dart';

class NewItemView extends StatefulWidget {
  final String nomeLista;

  const NewItemView({Key? key, required this.nomeLista}) : super(key: key);

  @override
  _NewItemViewState createState() => _NewItemViewState();
}

class _NewItemViewState extends State<NewItemView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nomeController;
  late TextEditingController quantidadeController;
  late TextEditingController unidadeController;
  late TextEditingController categoriaController;
  late TextEditingController notasController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController();
    quantidadeController = TextEditingController();
    unidadeController = TextEditingController();
    categoriaController = TextEditingController();
    notasController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  fillColor: Color.fromRGBO(227, 242, 253, 1),
                  filled: true,
                  contentPadding: EdgeInsets.all(6.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: quantidadeController,
                decoration: const InputDecoration(
                  labelText: 'Quantidade',
                  fillColor: Color.fromRGBO(227, 242, 253, 1),
                  filled: true,
                  contentPadding: EdgeInsets.all(6.0),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: unidadeController,
                decoration: const InputDecoration(
                  labelText: 'Unidade de Medida',
                  fillColor: Color.fromRGBO(227, 242, 253, 1),
                  filled: true,
                  contentPadding: EdgeInsets.all(6.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: categoriaController,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  fillColor: Color.fromRGBO(227, 242, 253, 1),
                  filled: true,
                  contentPadding: EdgeInsets.all(6.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: notasController,
                decoration: const InputDecoration(
                  labelText: 'Notas Adicionais',
                  fillColor: Color.fromRGBO(227, 242, 253, 1),
                  filled: true,
                  contentPadding: EdgeInsets.all(6.0),
                ),
                maxLines: null,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Item novoItem = Item(
                      nome: nomeController.text,
                      quantidade: double.parse(quantidadeController.text),
                      unidadeDeMedida: unidadeController.text,
                      categoria: categoriaController.text,
                      notasAdicionais: notasController.text,
                      comprado: false,
                    );
                    SimulaBD.adicionarItem(widget.nomeLista, novoItem);
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xFF047ffb);
                    } else if (states.contains(MaterialState.hovered)) {
                      return const Color(0xFF0a93ff);
                    } else {
                      return const Color(0xFF22b0ff);
                    }
                  }),
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Adicionar novo item',
                  style: TextStyle(color: Color.fromRGBO(227, 242, 253, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    quantidadeController.dispose();
    unidadeController.dispose();
    categoriaController.dispose();
    notasController.dispose();
    super.dispose();
  }
}
