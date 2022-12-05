import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../errors/errors_classes/errors_classes.dart';

import '../../domain/entities/Match/match_entity.dart';
import '../../domain/entities/Selection/selection_entity.dart';
import '../../domain/models/match_model.dart';
import '../controllers/match_store.dart';
import '../controllers/selection_store.dart';
import '../widgets/Cards/elimination_match_card.dart';
import '../widgets/my_scaffold.dart';

class QuarterScreen extends StatefulWidget {
  const QuarterScreen({super.key});

  @override
  State<QuarterScreen> createState() => _QuarterScreenState();
}

class _QuarterScreenState extends State<QuarterScreen> {
  final MatchStore matchStore = Modular.get<MatchStore>();
  final SelectionStore selectionStore = Modular.get<SelectionStore>();

  late List<Selecao> selections;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      selectionStore.getAllSelections();
      matchStore.getMatchsByType(SoccerMatchType.quarterFinals);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ScopedBuilder<MatchStore, Failure, List<SoccerMatch>>(
          store: matchStore,
          onLoading: (ctx) => const Center(
                child: SizedBox(
                  width: 200,
                  height: 300,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ),
          onError: (ctx, error) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red, fontSize: 14.5),
                ),
              ),
          onState: (ctx, matchs) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Quartas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: matchStore.state.length,
                    itemBuilder: (ctx, index) => _buildCard(index, matchs),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _buildCard(int i, List<SoccerMatch> matchs) {
    return EliminationMatchCard(
      store: matchStore,
      updateNextFaseMatchs: (match) async {
        matchStore.updateSemifinals(match: match);
      },
      width: MediaQuery.of(context).size.width * 0.9,
      match: SoccerMatchModel(
        match: matchStore.state[i],
        selection1: selectionStore.state
            .firstWhere((s) => s.id == matchs[i].idSelection1),
        selection2: selectionStore.state
            .firstWhere((s) => s.id == matchs[i].idSelection2),
      ),
    );
  }
}
