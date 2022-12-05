import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../domain/entities/Match/match_entity.dart';
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
          onLoading: (context) => const CircularProgressIndicator(),
          onState: (ctx, matchs) {
            if (matchs.length >= 4) {
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
                          matchStore.updateFinals(match: match);
                        },
                      ),
                      _buildCard(
                        match: matchs
                            .where((m) => m.type == SoccerMatchType.semifinals)
                            .last,
                        width: MediaQuery.of(context).size.width * 0.45,
                        function: (match) async {
                          matchStore.updateFinals(match: match);
                        },
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Text(
                      "Terceiro Lugar",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  _buildCard(
                    match: matchs.firstWhere(
                        (m) => m.type == SoccerMatchType.thirdPlace),
                    width: MediaQuery.of(context).size.width * 0.8,
                    function: (match) async {},
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Final",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  _buildCard(
                    match: matchs.firstWhere(
                        (m) => m.type == SoccerMatchType.finalMatch),
                    width: MediaQuery.of(context).size.width * 0.95,
                    function: (match) async {},
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
}
