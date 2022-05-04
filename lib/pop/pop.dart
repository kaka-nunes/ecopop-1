import 'dart:ffi';

class Pop {
  final int id;
  final String descricao;
  final String? conceito;
  final String? fonte;
  final String? formula;
  final String? experimento;
  final bool padrao;

  Pop(this.id, this.descricao, {this.conceito, this.fonte, this.formula, this.experimento, this.padrao = false});

  @override
  String toString() {
    return 'Expo{id: $id, descricao: $descricao}';
  }
}

class DadosPop {
  final int id;
  final int idPop;
  final Double quantidade;
  final Double tempo;

  DadosPop(this.id, this.idPop, this.quantidade, this.tempo);

}