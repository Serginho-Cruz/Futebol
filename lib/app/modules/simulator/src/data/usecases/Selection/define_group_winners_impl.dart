import '../../../domain/entities/Selection/selection_entity.dart';

import '../../../domain/usecases/Selection/define_group_winners_interface.dart';

class DefineGroupWinnersUC implements IDefineGroupWinners {
  @override
  List<Selecao> call(List<Selecao> selections) {
    int count = 1;
    int maior = selections.first.pontos;
    List<Selecao> newList = [];

    for (int i = 1; i < selections.length; i++) {
      int pontos = selections[i].pontos;
      if (pontos > maior) {
        maior = pontos;
        count = 1;
      } else if (pontos == maior) {
        count++;
      }
    }

    switch (count) {
      case 1:
        List<Selecao> copy = [];
        copy.addAll(selections);

        Selecao first = copy.firstWhere((s) => s.pontos == maior);
        copy.remove(first);

        newList.add(first);
        var seconds = _getSeconds(copy, maior);

        if (seconds.length == 1) {
          newList.add(seconds.first);
          return newList;
        } else {
          if (!_hasTieBetweenSecondAndThird(
            seconds[0],
            seconds[1],
          )) {
            newList.add(seconds.first);
            return newList;
          }
          var bySg = _breakTieBySg(seconds);
          if (bySg.isNotEmpty) {
            newList.add(bySg.first);
            return newList;
          }

          var byGp = _breakTieByGp(seconds);
          if (byGp.isNotEmpty) {
            newList.add(byGp.first);
            return newList;
          }

          copy.remove(first);
          copy.sort((a, b) => a.id.compareTo(b.id));
          copy.removeLast();
          copy.shuffle();
          return copy;
        }

      case 2:
        newList.addAll(selections.where((s) => s.pontos == maior).toList());

        var result = _breakTieBySg(newList);
        if (result.isNotEmpty) {
          return result;
        } else {
          newList.shuffle();
          return newList;
        }

      default:
        newList.addAll(selections);
        newList.shuffle();
        return newList.getRange(0, 1).toList();
    }
  }

  List<Selecao> _breakTieBySg(List<Selecao> selections) {
    Selecao first = selections.first;
    Selecao second = selections[1];

    if (_calcSg(second) > _calcSg(first)) {
      first = selections[1];
      second = selections.first;
    } else if (_calcSg(second) == _calcSg(first)) {
      return [];
    }

    return [first, second];
  }

  List<Selecao> _getSeconds(List<Selecao> selections, int greatestPontuation) {
    List<Selecao> seconds = [];
    int maior = 0;

    for (var selection in selections) {
      if (selection.pontos > maior && selection.pontos < greatestPontuation) {
        seconds.clear();
        seconds.add(selection);
        maior = selection.pontos;
      } else if (selection.pontos == maior) {
        seconds.add(selection);
      }
    }

    return seconds;
  }

  List<Selecao> _breakTieByGp(List<Selecao> selections) {
    Selecao winner = selections.first;
    Selecao loser = selections[1];

    if (loser.gp > winner.gp) {
      winner = selections.first;
      loser = selections[1];
    } else if (loser.gp == winner.gp) {
      return [];
    }

    return [winner, loser];
  }

  bool _hasTieBetweenSecondAndThird(Selecao second, Selecao third) =>
      second.pontos == third.pontos;

  int _calcSg(Selecao selection) => selection.gp - selection.gc;
}
