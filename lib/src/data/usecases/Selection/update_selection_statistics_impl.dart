// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:futebol/src/data/repository/selection_repository_interface.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/domain/usecases/Selection/update_selection_statistics_interface.dart';
import 'package:futebol/src/errors/errors_classes/errors_classes.dart';

class UpdateSelectionsStatisticsUC implements IUpdateSelectionStatistics {
  final ISelectionRepository repository;
  UpdateSelectionsStatisticsUC(this.repository);

  @override
  Future<Either<Failure, List<Selecao>>> call({
    required int selectionId1,
    required int selectionId2,
    required List<int> newScores,
    required List<int?> oldScores,
  }) async {
    List<Selecao> selectionsToUpdate;

    var result = await repository.getSelectionByIds(selectionId1, selectionId2);

    return result.fold((l) => Left(l), (selections) async {
      int actualWinner = newScores.first > newScores[1]
          ? selectionId1
          : newScores.first == newScores[1]
              ? 0
              : selectionId2;

      if (oldScores.first == null || oldScores[1] == null) {
        selectionsToUpdate = actualWinner == 0
            ? [
                _updateDataOnNull(
                  selection: selections.first,
                  newScores: [newScores.first, newScores[1]],
                  won: false,
                  draw: true,
                ),
                _updateDataOnNull(
                  selection: selections[1],
                  newScores: [newScores[1], newScores.first],
                  won: false,
                  draw: true,
                )
              ]
            : [
                _updateDataOnNull(
                  selection: selections.first,
                  newScores: [newScores.first, newScores[1]],
                  won: actualWinner == selections.first.id,
                ),
                _updateDataOnNull(
                  selection: selections[1],
                  newScores: [newScores[1], newScores.first],
                  won: actualWinner == selections[1].id,
                )
              ];
      } else {
        int oldWinner = oldScores.first! > oldScores[1]!
            ? selectionId1
            : oldScores.first! == oldScores[1]!
                ? 0
                : selectionId2;

        if (oldWinner == actualWinner) {
          selectionsToUpdate = [
            _updateGoalsOnly(
                selection: selections.first,
                oldScores: [oldScores.first!, oldScores[1]!],
                newScores: [newScores.first, newScores[1]]),
            _updateGoalsOnly(
                selection: selections[1],
                oldScores: [oldScores[1]!, oldScores.first!],
                newScores: [newScores[1], newScores.first])
          ];
        } else if (oldWinner == 0 || actualWinner == 0) {
          selectionsToUpdate = oldWinner == 0
              ? ([
                  _updateDataOnDraw(
                      selection: selections.first,
                      oldScores: [oldScores.first!, oldScores[1]!],
                      newScores: [newScores.first, newScores[1]],
                      drawOnActualMatch: false,
                      winnerId: actualWinner),
                  _updateDataOnDraw(
                      selection: selections[1],
                      oldScores: [oldScores[1]!, oldScores.first!],
                      newScores: [newScores[1], newScores.first],
                      drawOnActualMatch: false,
                      winnerId: actualWinner)
                ])
              : ([
                  _updateDataOnDraw(
                      selection: selections.first,
                      oldScores: [oldScores.first!, oldScores[1]!],
                      newScores: [newScores.first, newScores[1]],
                      drawOnActualMatch: true,
                      winnerId: oldWinner),
                  _updateDataOnDraw(
                      selection: selections[1],
                      oldScores: [oldScores[1]!, oldScores.first!],
                      newScores: [newScores[1], newScores.first],
                      drawOnActualMatch: true,
                      winnerId: oldWinner)
                ]);
        } else {
          selectionsToUpdate = [
            _updateData(
                selection: selections.first,
                oldScores: [oldScores.first!, oldScores[1]!],
                newScores: [newScores.first, newScores[1]],
                won: actualWinner == selectionId1),
            _updateData(
                selection: selections[1],
                oldScores: [oldScores[1]!, oldScores.first!],
                newScores: [newScores[1], newScores.first],
                won: actualWinner == selectionId2)
          ];
        }
      }
      var result =
          await repository.updateSelectionsStatistics(selectionsToUpdate);

      return result.fold((l) => Left(l), (r) => Right(selectionsToUpdate));
    });
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
    bool draw = false,
  }) {
    return draw
        ? Selecao(
            id: selection.id,
            bandeira: selection.bandeira,
            grupo: selection.grupo,
            nome: selection.nome,
            gp: selection.gp + newScores.first,
            gc: selection.gc + newScores[1],
            pontos: selection.pontos + 1,
            vitorias: selection.vitorias,
          )
        : Selecao(
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
