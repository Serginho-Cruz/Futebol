import 'package:equatable/equatable.dart';

class Selecao extends Equatable {
  final int? id;
  final String nome;
  final String bandeira;
  final int pontos;
  final int vitorias;
  final int gp;
  final int sg;
  final int gc;
  final String grupo;

  const Selecao({
    this.id,
    required this.nome,
    required this.bandeira,
    this.pontos = 0,
    this.vitorias = 0,
    this.gp = 0,
    this.sg = 0,
    this.gc = 0,
    required this.grupo,
  });

  @override
  List<Object?> get props => [
        id,
        nome,
        bandeira,
        grupo,
        pontos,
        vitorias,
        gp,
        gc,
        sg,
      ];
}
