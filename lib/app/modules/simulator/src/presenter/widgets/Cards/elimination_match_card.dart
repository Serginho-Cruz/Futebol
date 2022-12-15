import 'package:flutter/material.dart';
import '../../../domain/models/match_model.dart';
import '../../controllers/match_store.dart';

import '../../utils/colors.dart';
import 'match_card_image.dart';
import 'match_point.dart';

enum FieldType { normal, extraTime, penalty }

enum Scores { score1, score2, extratime1, extratime2, penalty1, penalty2 }

class EliminationMatchCard extends StatefulWidget {
  const EliminationMatchCard({
    super.key,
    required this.match,
    required this.store,
    required this.width,
    required this.updateNextFaseMatchs,
  });

  final SoccerMatchModel match;
  final MatchStore store;
  final double width;
  final Future<void> Function(SoccerMatchModel match) updateNextFaseMatchs;

  @override
  State<EliminationMatchCard> createState() => _EliminationMatchCardState();
}

class _EliminationMatchCardState extends State<EliminationMatchCard> {
  bool _isPenaltyVisible = false;
  bool _isExtraTimeVisible = false;
  bool _error = false;
  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

  @override
  void initState() {
    if (widget.match.score1 != null &&
        widget.match.score2 != null &&
        widget.match.score1 == widget.match.score2) {
      _isExtraTimeVisible = true;
    }

    if (widget.match.extratimeScore1 != null &&
        widget.match.extratimeScore2 != null &&
        widget.match.extratimeScore1 == widget.match.extratimeScore2) {
      _isPenaltyVisible = true;
    }

    super.initState();
  }

  void _hideField(FieldType field) {
    if (!mounted) {
      return;
    }
    setState(() {
      switch (field) {
        case FieldType.extraTime:
          _isExtraTimeVisible = false;
          widget.match.extratimeScore1 = null;
          widget.match.extratimeScore2 = null;

          break;
        case FieldType.penalty:
          _isPenaltyVisible = false;
          widget.match.penaltyScore1 = null;
          widget.match.penaltyScore2 = null;

          break;

        case FieldType.normal:
          break;
      }
    });
  }

  void _showField(FieldType field) {
    if (!mounted) {
      return;
    }
    setState(() {
      if (field == FieldType.extraTime) {
        _isExtraTimeVisible = true;
      } else {
        _isPenaltyVisible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool enabled =
        widget.match.idSelection1 != 33 && widget.match.idSelection2 != 33;

    return Card(
      elevation: 10.5,
      color: MyColors.normalPurple,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        side: BorderSide(color: MyColors.gray, width: 1.5),
      ),
      child: Container(
        alignment: Alignment.center,
        width: widget.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: MyColors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Text(
                '${widget.match.date}/2022',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(widget.match.hour),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MatchCardImage(selection: widget.match.selection1),
                  MatchPoint(
                    enabled: enabled,
                    point: widget.match.score1?.toString(),
                    onChanged: (str) {
                      _onChanged(
                        str: str,
                        scoreType: Scores.score1,
                        otherScore: widget.match.score2,
                        typeField: FieldType.normal,
                        fieldToShow: FieldType.extraTime,
                        fieldsToHide: [FieldType.extraTime, FieldType.penalty],
                      );
                    },
                    onSubmit: () {
                      focusNodes[1].requestFocus();
                    },
                    focus: focusNodes.first,
                  ),
                  MatchPoint(
                    enabled: enabled,
                    focus: focusNodes[1],
                    onChanged: (str) {
                      _onChanged(
                        str: str,
                        scoreType: Scores.score2,
                        otherScore: widget.match.score1,
                        typeField: FieldType.normal,
                        fieldToShow: FieldType.extraTime,
                        fieldsToHide: [FieldType.extraTime, FieldType.penalty],
                      );
                    },
                    onSubmit: () {
                      if (widget.match.score1 == widget.match.score2) {
                        focusNodes[2].requestFocus();
                      } else {
                        focusNodes[1].unfocus();
                      }
                    },
                    point: widget.match.score2?.toString(),
                  ),
                  MatchCardImage(selection: widget.match.selection2),
                ],
              ),
            ),
            _buildExtraTimeRow(
              text: "Tempo Extra",
              visible: _isExtraTimeVisible,
              focus1: focusNodes[2],
              focus2: focusNodes[3],
              focus3: focusNodes[4],
            ),
            _buildPenaltyRow(
              text: "Penaltys",
              visible: _isPenaltyVisible,
              focus1: focusNodes[4],
              focus2: focusNodes[5],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                widget.match.local,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var focus in focusNodes) {
      focus.dispose();
    }
    super.dispose();
  }

  Widget _buildExtraTimeRow({
    required String text,
    required bool visible,
    required FocusNode focus1,
    required FocusNode focus2,
    required FocusNode focus3,
  }) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                text,
                style: const TextStyle(color: Colors.amber),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: MatchPoint(
                    onChanged: (str) {
                      _onChanged(
                        str: str,
                        scoreType: Scores.extratime1,
                        otherScore: widget.match.extratimeScore2,
                        typeField: FieldType.extraTime,
                        fieldToShow: FieldType.penalty,
                        fieldsToHide: [FieldType.penalty],
                      );
                    },
                    point: widget.match.extratimeScore1?.toString(),
                    focus: focus1,
                    onSubmit: () {
                      focus2.requestFocus();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: MatchPoint(
                    onChanged: (str) {
                      _onChanged(
                        str: str,
                        scoreType: Scores.extratime2,
                        otherScore: widget.match.extratimeScore1,
                        typeField: FieldType.extraTime,
                        fieldToShow: FieldType.penalty,
                        fieldsToHide: [FieldType.penalty],
                      );
                    },
                    point: widget.match.extratimeScore2?.toString(),
                    focus: focus2,
                    onSubmit: () {
                      if (widget.match.extratimeScore1 ==
                          widget.match.extratimeScore2) {
                        focus3.requestFocus();
                      } else {
                        focus2.unfocus();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPenaltyRow({
    required bool visible,
    required FocusNode focus1,
    required FocusNode focus2,
    required String text,
  }) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                text,
                style: const TextStyle(color: Colors.amber),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: MatchPoint(
                    onChanged: (str) {
                      _onChanged(
                        str: str,
                        scoreType: Scores.penalty1,
                        otherScore: widget.match.penaltyScore2,
                        typeField: FieldType.penalty,
                      );
                    },
                    point: widget.match.penaltyScore1?.toString(),
                    focus: focus1,
                    onSubmit: () {
                      focus2.requestFocus();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: MatchPoint(
                    onChanged: (str) {
                      _onChanged(
                        str: str,
                        scoreType: Scores.penalty2,
                        otherScore: widget.match.penaltyScore1,
                        typeField: FieldType.penalty,
                      );
                    },
                    point: widget.match.penaltyScore2?.toString(),
                    focus: focus2,
                    onSubmit: () {
                      focus2.unfocus();
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Visibility(
                visible: _error,
                child: const Text(
                  "Fase de Pênaltis não pode ter empate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onChanged({
    required String str,
    required Scores scoreType,
    required int? otherScore,
    required FieldType typeField,
    List<FieldType> fieldsToHide = const [],
    FieldType? fieldToShow,
  }) {
    final updateScore = <Scores, int? Function(bool)>{
      Scores.score1: (bool assignNull) =>
          widget.match.score1 = assignNull ? null : int.tryParse(str),
      Scores.score2: (bool assignNull) =>
          widget.match.score2 = assignNull ? null : int.tryParse(str),
      Scores.extratime1: (bool assignNull) =>
          widget.match.extratimeScore1 = assignNull ? null : int.tryParse(str),
      Scores.extratime2: (bool assignNull) =>
          widget.match.extratimeScore2 = assignNull ? null : int.tryParse(str),
      Scores.penalty1: (bool assignNull) =>
          widget.match.penaltyScore1 = assignNull ? null : int.tryParse(str),
      Scores.penalty2: (bool assignNull) =>
          widget.match.penaltyScore2 = assignNull ? null : int.tryParse(str)
    };
    if (str.isNotEmpty) {
      int? number = updateScore[scoreType]!(false);
      if (otherScore != null) {
        switch (typeField) {
          case FieldType.normal:
            widget.store.changeKnockoutScoreboard(
              match: widget.match,
              score1: widget.match.score1!,
              score2: widget.match.score2!,
            );
            break;
          case FieldType.extraTime:
            widget.store.changeKnockoutScoreboard(
              match: widget.match,
              score1: widget.match.score1!,
              score2: widget.match.score2!,
              extratimeScores: [
                widget.match.extratimeScore1!,
                widget.match.extratimeScore2!
              ],
            );
            break;
          case FieldType.penalty:
            widget.store.changeKnockoutScoreboard(
              match: widget.match,
              score1: widget.match.score1!,
              score2: widget.match.score2!,
              extratimeScores: [
                widget.match.extratimeScore1!,
                widget.match.extratimeScore2!
              ],
              penaltyScores: [
                widget.match.penaltyScore1!,
                widget.match.penaltyScore2!,
              ],
            );
        }
        if (number == otherScore) {
          fieldToShow != null
              ? _showField(fieldToShow)
              : setState(() => _error = true);
        } else {
          widget.updateNextFaseMatchs(widget.match);

          if (fieldToShow == null) {
            setState(() => _error = false);
          }

          for (var field in fieldsToHide) {
            _hideField(field);
          }
        }
      }
    } else {
      updateScore[scoreType]!(true);
    }
  }
}
