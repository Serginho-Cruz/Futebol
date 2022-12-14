import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../controllers/selection_store.dart';

import '../../domain/entities/Match/match_entity.dart';
import '../../domain/models/match_model.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../controllers/match_store.dart';
import '../widgets/Cards/elimination_match_card.dart';
import '../widgets/my_scaffold.dart';

class Round16Screen extends StatefulWidget {
  const Round16Screen({super.key});

  @override
  State<Round16Screen> createState() => _Round16ScreenState();
}

class _Round16ScreenState extends State<Round16Screen> {
  final MatchStore store = Modular.get<MatchStore>();
  final SelectionStore selectionStore = Modular.get<SelectionStore>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      store.getMatchsByType(SoccerMatchType.round16);
      selectionStore.getAllSelections();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ScopedBuilder<MatchStore, Failure, List<SoccerMatch>>(
        store: store,
        onLoading: (ctx) => const Center(
          child: SizedBox(
            width: 200,
            height: 300,
            child: CircularProgressIndicator(
              color: Colors.lightBlue,
            ),
          ),
        ),
        onError: (ctx, error) => Text(error.toString()),
        onState: (ctx, matchs) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Oitavas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: store.state.length ~/ 2,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemBuilder: (ctx, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildCard(index * 2, matchs),
                      _buildCard(index * 2 + 1, matchs),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(int i, List<SoccerMatch> matchs) {
    return EliminationMatchCard(
      store: store,
      updateNextFaseMatchs: (match) => store.updateQuarters(match: match),
      width: MediaQuery.of(context).size.width * 0.45,
      match: SoccerMatchModel(
        match: matchs[i],
        selection1: selectionStore.state
            .firstWhere((e) => e.id == matchs[i].idSelection1),
        selection2: selectionStore.state
            .firstWhere((e) => e.id == matchs[i].idSelection2),
      ),
    );
  }
}
