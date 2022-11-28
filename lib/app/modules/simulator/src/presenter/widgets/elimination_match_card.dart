import 'package:flutter/material.dart';
import '../../domain/models/match_model.dart';
import '../controllers/match_store.dart';

import 'Cards/match_card_image.dart';
import 'Cards/match_point.dart';

enum FieldType {
  extraTime,
  penalty,
}

class EliminationMatchCard extends StatefulWidget {
  const EliminationMatchCard({
    super.key,
    required this.match,
    required this.store,
  });

  final SoccerMatchModel match;
  final MatchStore store;

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
      }
    });
  }

  void _showFields(FieldType field) {
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
    SoccerMatchModel match = widget.match;
    bool enabled = match.idSelection1 != 33 && match.idSelection2 != 33;

    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.45,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _showFields(FieldType.penalty),
            child: Container(
              height: 35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFF730217),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Text(
                '${match.date}/2022',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Text(match.hour),
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MatchCardImage(selection: match.selection1),
                MatchPoint(
                  enabled: enabled,
                  point: widget.match.score1?.toString(),
                  onChanged: (str) async {
                    if (str.isNotEmpty) {
                      widget.match.score1 = int.tryParse(str);

                      if (widget.match.score2 != null) {
                        await widget.store.changeKnockoutScoreboard(
                          match: match,
                          score1: widget.match.score1!,
                          score2: widget.match.score2!,
                        );

                        if (widget.match.score1 == widget.match.score2) {
                          _showFields(FieldType.extraTime);
                        } else {
                          await widget.store
                              .updateQuarterMatchs(match: widget.match);
                          _hideField(FieldType.extraTime);
                          _hideField(FieldType.penalty);
                        }
                      }
                    } else {
                      widget.match.score1 = null;
                    }
                  },
                  onSubmit: () {
                    focusNodes[1].requestFocus();
                  },
                  focus: focusNodes.first,
                ),
                MatchPoint(
                  enabled: enabled,
                  focus: focusNodes[1],
                  onChanged: (str) async {
                    if (str.isNotEmpty) {
                      widget.match.score2 = int.tryParse(str);
                      if (widget.match.score1 != null) {
                        await widget.store.changeKnockoutScoreboard(
                          match: match,
                          score1: widget.match.score1!,
                          score2: widget.match.score2!,
                        );

                        if (widget.match.score1 == widget.match.score2) {
                          _showFields(FieldType.extraTime);
                        } else {
                          await widget.store
                              .updateQuarterMatchs(match: widget.match);
                          _hideField(FieldType.extraTime);
                          _hideField(FieldType.penalty);
                        }
                      }
                    } else {
                      widget.match.score2 = null;
                    }
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
                MatchCardImage(selection: match.selection2),
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
                    onChanged: (str) async {
                      if (str.isNotEmpty) {
                        widget.match.extratimeScore1 = int.tryParse(str);

                        if (widget.match.extratimeScore2 != null) {
                          await widget.store.changeKnockoutScoreboard(
                            match: widget.match,
                            score1: widget.match.score1!,
                            score2: widget.match.score2!,
                            extratimeScores: [
                              widget.match.extratimeScore1!,
                              widget.match.extratimeScore2!
                            ],
                          );

                          if (widget.match.extratimeScore1 ==
                              widget.match.extratimeScore2) {
                            _showFields(FieldType.penalty);
                          } else {
                            _hideField(FieldType.penalty);
                            await widget.store
                                .updateQuarterMatchs(match: widget.match);
                          }
                        }
                      } else {
                        widget.match.extratimeScore1 = null;
                      }
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
                    onChanged: (str) async {
                      if (str.isNotEmpty) {
                        widget.match.extratimeScore2 = int.tryParse(str);

                        if (widget.match.extratimeScore1 != null) {
                          await widget.store.changeKnockoutScoreboard(
                            match: widget.match,
                            score1: widget.match.score1!,
                            score2: widget.match.score2!,
                            extratimeScores: [
                              widget.match.extratimeScore1!,
                              widget.match.extratimeScore2!
                            ],
                          );

                          if (widget.match.extratimeScore1 ==
                              widget.match.extratimeScore2) {
                            _showFields(FieldType.penalty);
                          } else {
                            _hideField(FieldType.penalty);
                            await widget.store
                                .updateQuarterMatchs(match: widget.match);
                          }
                        }
                      } else {
                        widget.match.extratimeScore2 = null;
                      }
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
                    onChanged: (str) async {
                      if (str.isNotEmpty) {
                        widget.match.penaltyScore1 = int.tryParse(str);

                        if (widget.match.penaltyScore2 != null) {
                          await widget.store.changeKnockoutScoreboard(
                              match: widget.match,
                              score1: widget.match.score1!,
                              score2: widget.match.score2!,
                              extratimeScores: [
                                widget.match.extratimeScore1!,
                                widget.match.extratimeScore2!
                              ],
                              penaltyScores: [
                                widget.match.penaltyScore1!,
                                widget.match.penaltyScore2!
                              ]);

                          if (widget.match.penaltyScore1 ==
                              widget.match.penaltyScore2) {
                            setState(() => _error = true);
                          } else {
                            widget.store
                                .updateQuarterMatchs(match: widget.match);
                          }
                        }
                      } else {
                        widget.match.penaltyScore1 = null;
                      }
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
                      if (str.isNotEmpty) {
                        widget.match.penaltyScore2 = int.tryParse(str);

                        if (widget.match.penaltyScore1 != null) {
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
                                widget.match.penaltyScore2!
                              ]);

                          if (widget.match.penaltyScore1 ==
                              widget.match.penaltyScore2) {
                            setState(() => _error = true);
                          } else {
                            setState(() => _error = false);
                            widget.store
                                .updateQuarterMatchs(match: widget.match);
                          }
                        }
                      } else {
                        widget.match.penaltyScore2 = null;
                      }
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
}
