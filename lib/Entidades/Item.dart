class Item {
  String nome;
  double quantidade;
  String unidadeDeMedida;
  String categoria;
  String? notasAdicionais;
  bool comprado;

  Item({
    required this.nome,
    required this.quantidade,
    required this.unidadeDeMedida,
    required this.categoria,
    this.notasAdicionais,
    required this.comprado,
  });
}
