import 'package:dartz/dartz.dart';
import 'package:futebol/src/data/repository/match_repository_interface.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/domain/usecases/changeScoreboard/change_scoreboard_interface.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

class ChangeScoreboard implements IChangeScoreboard {
  final IMatchRepository repository;

  ChangeScoreboard(this.repository);

  @override
  Future<Either<Failure, List<Selecao>>> call({
    required int selectionId1,
    required int selectionId2,
    required int score1,
    required int score2,
    required int matchId,
  }) async {
    var result = await repository.getMatchById(matchId);
    List<Selecao> selectionsToUpdate;

    return result.fold((l) => Left(l), (match) async {
      var result =
          await repository.getSelectionByIds(selectionId1, selectionId2);

      return result.fold((l) => Left(l), (selections) async {
        int actualWinner = _defineWinner(
            score1: score1,
            score2: score2,
            selection1Id: selectionId1,
            selection2Id: selectionId2);

        if (match.score1 == null || match.score2 == null) {
          selectionsToUpdate = [
            _updateDataOnNull(
              selection: selections.first,
              newScores: [score1, score2],
              won: actualWinner == selections.first.id,
            ),
            _updateDataOnNull(
                selection: selections[1],
                newScores: [score2, score1],
                won: actualWinner == selections[1].id)
          ];
        } else {
          int oldWinner = _defineWinner(
              score1: match.score1!,
              score2: match.score2!,
              selection1Id: selectionId1,
              selection2Id: selectionId2);

          if (oldWinner == actualWinner) {
            selectionsToUpdate = [
              _updateGoalsOnly(
                  selection: selections.first,
                  oldScores: [match.score1!, match.score2!],
                  newScores: [score1, score2]),
              _updateGoalsOnly(
                  selection: selections[1],
                  oldScores: [match.score2!, match.score1!],
                  newScores: [score2, score1])
            ];
          } else if (oldWinner == 0 || actualWinner == 0) {
            selectionsToUpdate = oldWinner == 0
                ? ([
                    _updateDataOnDraw(
                        selection: selections.first,
                        oldScores: [match.score1!, match.score2!],
                        newScores: [score1, score2],
                        drawOnActualMatch: false,
                        winnerId: actualWinner),
                    _updateDataOnDraw(
                        selection: selections[1],
                        oldScores: [match.score2!, match.score1!],
                        newScores: [score2, score1],
                        drawOnActualMatch: false,
                        winnerId: actualWinner)
                  ])
                : ([
                    _updateDataOnDraw(
                        selection: selections.first,
                        oldScores: [match.score1!, match.score2!],
                        newScores: [score1, score2],
                        drawOnActualMatch: true,
                        winnerId: actualWinner),
                    _updateDataOnDraw(
                        selection: selections[1],
                        oldScores: [match.score2!, match.score1!],
                        newScores: [score2, score1],
                        drawOnActualMatch: true,
                        winnerId: actualWinner)
                  ]);
          } else {
            selectionsToUpdate = [
              _updateData(
                  selection: selections.first,
                  oldScores: [match.score1!, match.score2!],
                  newScores: [score1, score2],
                  won: actualWinner == selectionId1),
              _updateData(
                  selection: selections[1],
                  oldScores: [match.score2!, match.score1!],
                  newScores: [score2, score1],
                  won: actualWinner == selectionId2)
            ];
          }
        }
        //var result = await repository.changeScoreboard(selectionsToUpdate);
        return Right(selectionsToUpdate);
      });
    });
  }

  int _defineWinner({
    required int selection1Id,
    required int selection2Id,
    required int score1,
    required int score2,
  }) {
    if (score1 > score2) {
      return selection1Id;
    } else if (score1 == score2) {
      return 0;
    } else {
      return selection2Id;
    }
  }

  //Método auxiliar que altera todos os dados "mutáveis",
  //use quando a seleção ganhou/perdeu a partida
  Selecao _updateData({
    required Selecao selection,
    required List<int> oldScores,
    required List<int> newScores,
    required bool won,
  }) {
    return Selecao(
      id: selection.id,
      bandeira: selection.bandeira,
      grupo: selection.grupo,
      nome: selection.nome,
      gp: selection.gp - oldScores[0] + newScores[0],
      gc: selection.gc - oldScores[1] + newScores[1],
      pontos: won ? selection.pontos + 3 : selection.pontos - 3,
      vitorias: won ? selection.vitorias + 1 : selection.vitorias - 1,
    );
  }

  Selecao _updateDataOnNull({
    required Selecao selection,
    required List<int> newScores,
    required bool won,
  }) {
    return Selecao(
      id: selection.id,
      bandeira: selection.bandeira,
      grupo: selection.grupo,
      nome: selection.nome,
      gp: selection.gp + newScores.first,
      gc: selection.gc + newScores[1],
      pontos: won ? selection.pontos + 3 : selection.pontos,
      vitorias: won ? selection.vitorias + 1 : selection.vitorias,
    );
  }

  Selecao _updateDataOnDraw(
      {required Selecao selection,
      required List<int> oldScores,
      required List<int> newScores,
      required bool drawOnActualMatch,
      required int winnerId}) {
    if (drawOnActualMatch) {
      return Selecao(
        id: selection.id,
        bandeira: selection.bandeira,
        grupo: selection.grupo,
        nome: selection.nome,
        gp: selection.gp - oldScores[0] + newScores[0],
        gc: selection.gc - oldScores[1] + newScores[1],
        pontos: winnerId == selection.id
            ? selection.pontos - 2
            : selection.pontos + 1,
        vitorias: winnerId == selection.id
            ? selection.vitorias - 1
            : selection.vitorias,
      );
    } else {
      return Selecao(
        id: selection.id,
        bandeira: selection.bandeira,
        grupo: selection.grupo,
        nome: selection.nome,
        gp: selection.gp - oldScores[0] + newScores[0],
        gc: selection.gc - oldScores[1] + newScores[1],
        pontos: winnerId == selection.id
            ? selection.pontos + 2
            : selection.pontos - 1,
        vitorias: winnerId == selection.id
            ? selection.vitorias + 1
            : selection.vitorias,
      );
    }
  }

  //Método auxiliar que altera os gols da seleção, que será enviado
  //pro Banco e retornado
  Selecao _updateGoalsOnly({
    required Selecao selection,
    required List<int> oldScores,
    required List<int> newScores,
  }) {
    return Selecao(
      id: selection.id,
      bandeira: selection.bandeira,
      grupo: selection.grupo,
      nome: selection.nome,
      gp: selection.gp - oldScores[0] + newScores[0],
      gc: selection.gc - oldScores[1] + newScores[1],
      pontos: selection.pontos,
      vitorias: selection.vitorias,
    );
  }
}
