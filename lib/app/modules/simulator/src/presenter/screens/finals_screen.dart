import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../domain/entities/Match/match_entity.dart';
import '../../domain/entities/Selection/selection_entity.dart';
import '../../domain/models/match_model.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../controllers/match_store.dart';
import '../widgets/Cards/elimination_match_card.dart';
import '../widgets/my_scaffold.dart';

import '../controllers/selection_store.dart';

class FinalsScreen extends StatefulWidget {
  const FinalsScreen({super.key});

  @override
  State<FinalsScreen> createState() => _FinalsScreenState();
}

class _FinalsScreenState extends State<FinalsScreen> {
  final MatchStore matchStore = Modular.get<MatchStore>();
  final SelectionStore selectionStore = Modular.get<SelectionStore>();

  int? winner;
  int? second;
  int? third;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      matchStore.getFinalMatchs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ScopedBuilder<MatchStore, Failure, List<SoccerMatch>>(
          store: matchStore,
          onError: (context, error) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          onState: (ctx, matchs) {
            if (matchs.any((m) => m.type == SoccerMatchType.semifinals)) {
              var finalMatch = matchs
                  .firstWhere((s) => s.type == SoccerMatchType.finalMatch);
              var thirdPlaceMatch = matchs
                  .firstWhere((s) => s.type == SoccerMatchType.thirdPlace);

              winner = matchStore.defineKnockoutWinner(finalMatch);
              second = winner == finalMatch.idSelection1
                  ? finalMatch.idSelection2
                  : finalMatch.idSelection1;

              third = matchStore.defineKnockoutWinner(thirdPlaceMatch);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 12.0),
                    child: Text(
                      "Semifinais",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCard(
                        match: matchs
                            .where((m) => m.type == SoccerMatchType.semifinals)
                            .first,
                        width: MediaQuery.of(context).size.width * 0.45,
                        function: (match) async {
                          await matchStore.updateFinals(match: match);
                          matchStore.getFinalMatchs();
                        },
                      ),
                      _buildCard(
                        match: matchs
                            .where((m) => m.type == SoccerMatchType.semifinals)
                            .last,
                        width: MediaQuery.of(context).size.width * 0.45,
                        function: (match) async {
                          await matchStore.updateFinals(match: match);
                          matchStore.getFinalMatchs();
                        },
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Text(
                      "Terceiro Lugar",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  _buildCard(
                    match: thirdPlaceMatch,
                    width: MediaQuery.of(context).size.width * 0.8,
                    function: (match) async {
                      matchStore.getFinalMatchs();
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Final",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  _buildCard(
                    match: finalMatch,
                    width: MediaQuery.of(context).size.width * 0.95,
                    function: (match) async {
                      matchStore.getFinalMatchs();
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      "Podium",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildImage(
                        trophyLocation:
                            'assets/images/trophies/trofeu_bronze.png',
                        selectionId: third ?? 33,
                        trophyWidth: MediaQuery.of(context).size.width * 0.2,
                        imageWidth: MediaQuery.of(context).size.width * 0.22,
                        imageHeight: MediaQuery.of(context).size.height * 0.06,
                      ),
                      _buildImage(
                        trophyLocation:
                            'assets/images/trophies/trofeu_ouro.png',
                        selectionId: winner ?? 33,
                        trophyWidth: MediaQuery.of(context).size.width * 0.33,
                        imageWidth: MediaQuery.of(context).size.width * 0.25,
                        imageHeight: MediaQuery.of(context).size.height * 0.075,
                      ),
                      _buildImage(
                        trophyLocation:
                            'assets/images/trophies/trofeu_prata.png',
                        selectionId: second ?? 33,
                        trophyWidth: MediaQuery.of(context).size.width * 0.24,
                        imageWidth: MediaQuery.of(context).size.width * 0.25,
                        imageHeight: MediaQuery.of(context).size.height * 0.06,
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCard({
    required SoccerMatch match,
    required double width,
    required Future<void> Function(SoccerMatch match) function,
  }) {
    return EliminationMatchCard(
      match: SoccerMatchModel(
        match: match,
        selection1:
            selectionStore.state.firstWhere((s) => s.id == match.idSelection1),
        selection2: selectionStore.state.firstWhere(
          (s) => s.id == match.idSelection2,
        ),
      ),
      store: matchStore,
      width: width,
      updateNextFaseMatchs: function,
    );
  }

  Widget _buildImage({
    required String trophyLocation,
    required int selectionId,
    required double trophyWidth,
    required double imageWidth,
    required double imageHeight,
  }) {
    Selecao selection =
        selectionStore.state.firstWhere((s) => s.id == selectionId);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/flags/${selection.bandeira}.png',
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Image.asset(
            trophyLocation,
            width: trophyWidth,
          ),
        ),
      ],
    );
  }
}
