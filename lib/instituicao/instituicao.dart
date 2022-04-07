class Instituicao {
  final int? id;
  final String descricao;
  final String? sigla;

  Instituicao({this.id, required this.descricao, this.sigla});

  @override
  String toString() {
    return 'Instituicao{id: $id, descricao: $descricao, sigla: $sigla}';
  }
}
