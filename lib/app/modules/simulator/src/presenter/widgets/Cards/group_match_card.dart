import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/models/match_model.dart';
import '../../controllers/match_store.dart';
import '../../controllers/selection_store.dart';
import '../../utils/colors.dart';
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
    _focus1 = focus1;
    _focus2 = focus2;
  }

  SoccerMatchModel match;
  final MatchStore matchStore;
  final bool Function() hasMatchsFinished;
  late final FocusNode _focus1;
  late final FocusNode _focus2;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 10.0,
      color: MyColors.normalPurple,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        side: BorderSide(
          color: Color.fromRGBO(74, 78, 105, 0.5),
          width: 1.5,
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
                child: MatchPoint(
                  focus: _focus1,
                  point: match.score1?.toString(),
                  onSubmit: () {
                    if (match.score2 == null) {
                      _focus2.requestFocus();
                    } else {
                      _focus1.unfocus();
                    }
                  },
                  onChanged: (str) => _onChanged(str, true),
                ),
              ),
              Flexible(
                child: MatchPoint(
                  focus: _focus2,
                  point: match.score2?.toString(),
                  onSubmit: () {
                    _focus2.unfocus();
                  },
                  onChanged: (str) => _onChanged(str, false),
                ),
              ),
              MatchCardImage(selection: match.selection2),
            ],
          ),
          Text(
            match.local,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 12.5,
            ),
          )
        ],
      ),
    );
  }

  void _onChanged(String str, bool isFirstSelection) async {
    if (str.trim().isNotEmpty) {
      isFirstSelection
          ? match.score1 = int.tryParse(str)
          : match.score2 = int.tryParse(str);

      if ((isFirstSelection ? match.score2 : match.score1) != null) {
        List<int?>? oldScores = await matchStore.changeGroupScoreboard(
          match: match,
          score1: match.score1!,
          score2: match.score2!,
        );

        if (oldScores != null) {
          Modular.get<SelectionStore>().updateStatistics(
            selectionId1: match.idSelection1,
            selectionId2: match.idSelection2,
            group: match.group!,
            newScores: [match.score1!, match.score2!],
            oldScores: oldScores,
          );
        }
      }
    } else {
      isFirstSelection ? match.score1 = null : match.score2 = null;
    }

    if (hasMatchsFinished()) {
      matchStore.updateRound16(
        selections: Modular.get<SelectionStore>().state,
        group: match.group!,
      );
    }
  }
}
