import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:futebol/app/modules/simulator/src/domain/models/match_model.dart';
import 'package:futebol/app/modules/simulator/src/presenter/controllers/match_store.dart';

import '../../controllers/selection_store.dart';
import 'match_card_image.dart';
import 'match_point.dart';

class GroupMatchCard extends StatelessWidget {
  GroupMatchCard({
    super.key,
    required this.match,
    required this.hasMatchsFinished,
    required this.matchStore,
    required FocusNode focus1,
    required FocusNode focus2,
  }) {
    point1 = match.score1;
    point2 = match.score2;
    _focus1 = focus1;
    _focus2 = focus2;
  }

  SoccerMatchModel match;
  int? point1;
  int? point2;
  final MatchStore matchStore;
  final bool Function() hasMatchsFinished;
  late final FocusNode _focus1;
  late final FocusNode _focus2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: const Color.fromRGBO(74, 78, 105, 0.5),
          width: 1,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 35,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF730217),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
            ),
            child: Text(
              '${match.date}/2022',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Text(match.hour),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MatchCardImage(selection: match.selection1),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 4.0, right: 4.0, top: 17.5),
                  child: MatchPoint(
                    focus: _focus1,
                    point: match.score1?.toString(),
                    onSubmit: () {
                      if (point2 == null) {
                        _focus2.requestFocus();
                      } else {
                        _focus1.unfocus();
                      }
                    },
                    onChanged: (str) async {
                      if (str.isNotEmpty) {
                        point1 = int.tryParse(str);

                        if (point2 != null) {
                          List<int?>? oldScores =
                              await Modular.get<MatchStore>()
                                  .changeGroupScoreboard(
                            match: match,
                            score1: point1!,
                            score2: point2!,
                          );

                          if (oldScores != null) {
                            await Modular.get<SelectionStore>()
                                .updateStatistics(
                              selectionId1: match.idSelection1,
                              selectionId2: match.idSelection2,
                              group: match.group!,
                              newScores: [point1!, point2!],
                              oldScores: oldScores,
                            );
                          }
                        }
                      } else {
                        point1 = null;
                      }

                      if (hasMatchsFinished()) {
                        matchStore.updateRound16Matchs(
                          selections: Modular.get<SelectionStore>().state,
                          group: match.group!,
                        );
                      }
                    },
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 4.0, right: 4.0, top: 17.5),
                  child: MatchPoint(
                    focus: _focus2,
                    point: match.score2?.toString(),
                    onSubmit: () {
                      if (point1 == null) {
                        _focus1.requestFocus();
                      } else {
                        _focus2.unfocus();
                      }
                    },
                    onChanged: (str) async {
                      if (str.trim().isNotEmpty) {
                        point2 = int.tryParse(str);

                        if (point1 != null) {
                          List<int?>? oldScores =
                              await matchStore.changeGroupScoreboard(
                            match: match,
                            score1: point1!,
                            score2: point2!,
                          );

                          if (oldScores != null) {
                            Modular.get<SelectionStore>().updateStatistics(
                              selectionId1: match.idSelection1,
                              selectionId2: match.idSelection2,
                              group: match.group!,
                              newScores: [point1!, point2!],
                              oldScores: oldScores,
                            );
                          }
                        }
                      } else {
                        point2 = null;
                      }

                      if (hasMatchsFinished()) {
                        matchStore.updateRound16Matchs(
                          selections: Modular.get<SelectionStore>().state,
                          group: match.group!,
                        );
                      }
                    },
                  ),
                ),
              ),
              MatchCardImage(selection: match.selection2),
            ],
          ),
          Text(
            match.local,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          )
        ],
      ),
    );
  }
}
