import 'package:dartz/dartz.dart';
import 'package:futebol/src/data/repository/repository_interface.dart';

import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

class ChangeScoreboard {
  final IRepository repository;

  ChangeScoreboard(this.repository);

  Future<Either<Failure, List<Selecao>>> call({
    required int selectionId1,
    required int selectionId2,
    required int score1,
    required int score2,
    required int matchId,
  }) async {
    var result = await repository.getSelectionByIds(selectionId1, selectionId2);

    return result.fold((l) => Left(l), (list) async {
      var match = await repository.getMatchById(matchId);

      return match.fold((l) => Left(l), (match) {
        // Não finalizado
        if (match.score1 == null || match.score2 == null) {
          return Right([
            Selecao(
                nome: list[0].nome,
                bandeira: list[0].bandeira,
                grupo: list[0].grupo)
          ]);
        } else {
          var newScores = [score1, score2];

          if (match.score1! > match.score2!) {
            if (score1 > score2) {
              return Right([
                _updateGoalsOnly(
                  selecao: list.first,
                  oldScores: [match.score1!, match.score2!],
                  newScores: [score1, score2],
                ),
                _updateGoalsOnly(
                  selecao: list[1],
                  oldScores: [match.score2!, match.score1!],
                  newScores: [score2, score1],
                ),
              ]);
            } else if (score1 < score2) {
              return Right([
                _updateData(
                  selecao: list.first,
                  oldScores: [match.score1!, match.score2!],
                  newScores: [score1, score2],
                  won: false,
                ),
                _updateData(
                  selecao: list[1],
                  oldScores: [match.score2!, match.score1!],
                  newScores: [score2, score1],
                  won: true,
                )
              ]);
            } else {
              // Ainda não pensei na lógica dos casos de empate
              return Right([
                Selecao(
                  id: selectionId1,
                  nome: list.first.nome,
                  bandeira: list.first.bandeira,
                  grupo: list.first.grupo,
                  gp: list.first.gp - match.score1! + score1,
                  gc: list.first.gc - match.score2! + score2,
                  pontos: list.first.pontos - 2,
                  vitorias: list.first.vitorias - 1,
                ),
                Selecao(
                  id: selectionId2,
                  nome: list[1].nome,
                  bandeira: list[1].bandeira,
                  grupo: list[1].grupo,
                  gp: list[1].gp - match.score2! + score2,
                  gc: list[1].gc - match.score1! + score1,
                  pontos: list[1].pontos + 1,
                  vitorias: list[1].vitorias,
                )
              ]);
            }
          } else if (match.score1! < match.score2!) {
            if (score1 > score2) {
              return Right([
                _updateData(
                  selecao: list.first,
                  oldScores: [match.score1!, match.score2!],
                  newScores: [score1, score2],
                  won: true,
                ),
                _updateData(
                  selecao: list[1],
                  oldScores: [match.score2!, match.score1!],
                  newScores: [score2, score1],
                  won: false,
                )
              ]);
            } else if (score1 < score2) {
              return Right([
                _updateGoalsOnly(
                  selecao: list.first,
                  oldScores: [match.score1!, match.score2!],
                  newScores: [score1, score2],
                ),
                _updateGoalsOnly(
                  selecao: list[1],
                  oldScores: [match.score2!, match.score1!],
                  newScores: [score2, score1],
                )
              ]);
            } else {
              return Right([
                Selecao(
                  id: selectionId1,
                  nome: list.first.nome,
                  bandeira: list.first.bandeira,
                  grupo: list.first.grupo,
                  gp: list.first.gp - match.score1! + score1,
                  gc: list.first.gc - match.score2! + score2,
                  pontos: list.first.pontos + 1,
                  vitorias: list.first.vitorias,
                ),
                Selecao(
                  id: selectionId2,
                  nome: list[1].nome,
                  bandeira: list[1].bandeira,
                  grupo: list[1].grupo,
                  gp: list[1].gp - match.score2! + score2,
                  gc: list[1].gc - match.score1! + score1,
                  pontos: list[1].pontos - 2,
                  vitorias: list[1].vitorias - 1,
                )
              ]);
            }
          } else {
            if (score1 > score2) {
              return Right([
                Selecao(
                  id: selectionId1,
                  nome: list.first.nome,
                  bandeira: list.first.bandeira,
                  grupo: list.first.grupo,
                  gp: list.first.gp - match.score1! + score1,
                  gc: list.first.gc - match.score2! + score2,
                  pontos: list.first.pontos + 2,
                  vitorias: list.first.vitorias + 1,
                ),
                Selecao(
                  id: selectionId2,
                  nome: list[1].nome,
                  bandeira: list[1].bandeira,
                  grupo: list[1].grupo,
                  gp: list[1].gp - match.score2! + score2,
                  gc: list[1].gc - match.score1! + score1,
                  pontos: list[1].pontos - 1,
                  vitorias: list[1].vitorias,
                )
              ]);
            } else if (score1 < score2) {
              return Right([
                Selecao(
                  id: selectionId1,
                  nome: list.first.nome,
                  bandeira: list.first.bandeira,
                  grupo: list.first.grupo,
                  gp: list.first.gp - match.score1! + score1,
                  gc: list.first.gc - match.score2! + score2,
                  pontos: list.first.pontos - 1,
                  vitorias: list.first.vitorias,
                ),
                Selecao(
                  id: selectionId2,
                  nome: list[1].nome,
                  bandeira: list[1].bandeira,
                  grupo: list[1].grupo,
                  gp: list[1].gp - match.score2! + score2,
                  gc: list[1].gc - match.score1! + score1,
                  pontos: list[1].pontos + 2,
                  vitorias: list[1].vitorias + 1,
                )
              ]);
            } else {
              return Right([
                _updateGoalsOnly(
                  selecao: list.first,
                  oldScores: [match.score1!, match.score2!],
                  newScores: [score1, score2],
                ),
                _updateGoalsOnly(
                  selecao: list[1],
                  oldScores: [match.score2!, match.score1!],
                  newScores: [score2, score1],
                ),
              ]);
            }
          }
        }
      });
    });
  }

  //Método auxiliar que altera todos os dados "mutáveis",
  //use quando a seleção ganhou/perdeu a partida
  Selecao _updateData({
    required Selecao selecao,
    required List<int> oldScores,
    required List<int> newScores,
    required bool won,
  }) {
    return Selecao(
      id: selecao.id,
      bandeira: selecao.bandeira,
      grupo: selecao.grupo,
      nome: selecao.nome,
      gp: selecao.gp - oldScores[0] + newScores[0],
      gc: selecao.gc - oldScores[1] + newScores[1],
      pontos: won ? selecao.pontos + 3 : selecao.pontos - 3,
      vitorias: won ? selecao.vitorias + 1 : selecao.vitorias - 1,
    );
  }

  //Método auxiliar que altera os gols da seleção, que será enviado
  //pro Banco e retornado
  Selecao _updateGoalsOnly({
    required Selecao selecao,
    required List<int> oldScores,
    required List<int> newScores,
  }) {
    return Selecao(
      id: selecao.id,
      bandeira: selecao.bandeira,
      grupo: selecao.grupo,
      nome: selecao.nome,
      gp: selecao.gp - oldScores[0] + newScores[0],
      gc: selecao.gc - oldScores[1] + newScores[1],
      pontos: selecao.pontos,
      vitorias: selecao.vitorias,
    );
  }
}
