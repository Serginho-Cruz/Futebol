import 'selection_entity.dart';

class SelecaoMapper {
  static Map<String, dynamic> toMap(Selecao selecao) {
    return <String, dynamic>{
      'id': selecao.id,
      'nome': selecao.nome,
      'bandeira': selecao.bandeira,
      'pontos': selecao.pontos,
      'vitorias': selecao.vitorias,
      'gp': selecao.gp,
      'gc': selecao.gc,
      'grupo': selecao.grupo,
    };
  }

  static Selecao fromMap(Map<String, dynamic> map) {
    return Selecao(
      id: map['id'] as int,
      nome: map['nome'] as String,
      bandeira: map['bandeira'] as String,
      pontos: map['pontos'] as int,
      vitorias: map['vitorias'] as int,
      gp: map['gp'] as int,
      gc: map['gc'] as int,
      grupo: map['grupo'] as String,
    );
  }
}
