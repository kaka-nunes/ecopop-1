class Instituicao {
  final String? uuid;
  final int id;
  final String descricao;
  final String? sigla;

  Instituicao({this.uuid, required this.id, required this.descricao, this.sigla});

  @override
  String toString() {
    return 'Instituicao{uuid: $uuid, id: $id, descricao: $descricao, sigla: $sigla}';
  }
}
