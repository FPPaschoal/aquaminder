import 'package:AquaMinder/Entidades/Item.dart';

class Lista {
  String nome;
  List<Item> itens;

  Lista({
    required this.nome,
    List<Item>? itens,
  }) : itens = itens ?? [];

  void adicionarItem(Item novoItem) {
    itens.add(novoItem);
  }

  void excluirItem(String nomeItem) {
    itens.removeWhere((item) => item.nome == nomeItem);
  }
}
