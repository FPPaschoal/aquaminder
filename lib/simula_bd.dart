import 'package:AquaMinder/Entidades/Item.dart';
import 'package:AquaMinder/Entidades/Lista.dart';

class SimulaBD {
  static String email = 'adm@admin.com';
  static String senha = 'admin123';
  // static String email = '1';
  // static String senha = '1';

  static List<Lista> listas = [
    Lista(nome: 'Lista de Mercado', itens: [
      Item(
        nome: 'Bananas',
        quantidade: 6,
        unidadeDeMedida: 'un',
        categoria: 'Frutas',
        comprado: true,
      ),
      Item(
        nome: 'Papel Toalha',
        quantidade: 1,
        unidadeDeMedida: 'rolo',
        categoria: 'Limpeza',
        comprado: false,
      ),
      Item(
        nome: 'Creme Dental',
        quantidade: 1,
        unidadeDeMedida: 'un',
        categoria: 'Higiene',
        comprado: true,
      ),
      Item(
        nome: 'Leite',
        quantidade: 1,
        unidadeDeMedida: 'L',
        categoria: 'Laticínios',
        comprado: false,
      ),
      Item(
        nome: 'Arroz',
        quantidade: 1,
        unidadeDeMedida: 'kg',
        categoria: 'Grãos',
        comprado: false,
      ),
      Item(
        nome: 'Sabonete',
        quantidade: 3,
        unidadeDeMedida: 'un',
        categoria: 'Higiene',
        comprado: false,
      ),
    ]),
    Lista(
      nome: 'Lista Marcenaria',
      itens: [
        Item(
          nome: 'Tábuas de Pinho',
          quantidade: 5,
          unidadeDeMedida: 'un',
          categoria: 'Madeira',
          comprado: false,
        ),
        Item(
          nome: 'Parafusos',
          quantidade: 100,
          unidadeDeMedida: 'un',
          categoria: 'Ferragens',
          comprado: true,
        ),
        Item(
          nome: 'Lixa de Grão Médio',
          quantidade: 3,
          unidadeDeMedida: 'un',
          categoria: 'Acabamento',
          comprado: false,
        ),
        Item(
          nome: 'Trena',
          quantidade: 1,
          unidadeDeMedida: 'un',
          categoria: 'Ferramentas',
          comprado: false,
        ),
        Item(
          nome: 'Tinta para Madeira',
          quantidade: 2,
          unidadeDeMedida: 'L',
          categoria: 'Acabamento',
          comprado: false,
        ),
      ],
    )
  ];

  static bool login(String Email, String Senha) {
    return Email == email && Senha == senha ? true : false;
  }

  static int contarItensComprados(String nomeLista) {
    Lista? lista = encontraLista(nomeLista);
    if (lista != null) {
      int totalItens = lista.itens.length;
      int itensComprados = lista.itens.where((item) => item.comprado).length;
      return itensComprados;
    } else {
      return 0;
    }
  }

  static String? recuperarSenha(String emailDeRecuperacao) {
    return email == emailDeRecuperacao ? senha : null;
  }

  static void criarLista(String nomeLista) {
    bool listaExistente = listas.any((lista) => lista.nome == nomeLista);

    if (!listaExistente) {
      Lista novaLista = Lista(nome: nomeLista, itens: []);
      listas.add(novaLista);
    }
  }

  static void editaNomeLista(String nomeAntigo, String nomeNovo) {
    int index = encontraIndexLista(nomeAntigo);

    listas[index].nome = nomeNovo;
  }

  static List<String> recuperarListas() {
    return listas.map((lista) => lista.nome).toList();
  }

  static void excluirLista(String nomeLista) {
    int index = encontraIndexLista(nomeLista);

    if (index != -1) {
      listas.removeAt(index);
    }
  }

  static int encontraIndexLista(String nomeLista) {
    int index = -1;
    for (int i = 0; i < listas.length; i++) {
      if (listas[i].nome == nomeLista) {
        index = i;
        break;
      }
    }
    return index;
  }

  static Lista? encontraLista(String nomeLista) {
    int index = encontraIndexLista(nomeLista);
    return listas[index];
  }

  static void adicionarItem(String nomeLista, Item novoItem) {
    int index = encontraIndexLista(nomeLista);

    if (!listas[index].itens.any((element) => element.nome == novoItem.nome)) {
      listas[index].adicionarItem(novoItem);
    }
  }

  static void excluirItem(String nomeLista, String nomeItem) {
    int indexLista = encontraIndexLista(nomeLista);

    if (indexLista != -1) {
      listas[indexLista].excluirItem(nomeItem);
    }
  }

  static List<Item> recuperarItens(String nomeLista) {
    Lista? listaEncontrada = encontraLista(nomeLista);

    return listaEncontrada != null ? listaEncontrada.itens : [];
  }

  static void editarItem(String nomeLista, Item itemAntigo, Item novoItem) {
    int index = encontraIndexLista(nomeLista);

    Item antigo = listas[index]
        .itens
        .firstWhere((element) => element.nome == itemAntigo.nome);

    antigo.nome = novoItem.nome;
    antigo.categoria = novoItem.categoria;
    antigo.notasAdicionais = novoItem.notasAdicionais;
    antigo.quantidade = novoItem.quantidade;
    antigo.unidadeDeMedida = novoItem.unidadeDeMedida;
  }

  static void comprarItem(String nomeLista, String nomeItem) {
    Item? item = pesquisarItem(nomeLista, nomeItem);
    if (item != null) item.comprado = !item.comprado;
  }

  static Item? pesquisarItem(String nomeLista, String nomeItem) {
    int index = encontraIndexLista(nomeLista);

    try {
      return listas[index]
          .itens
          .firstWhere((element) => element.nome == nomeItem);
    } catch (e) {
      return null;
    }
  }
}
