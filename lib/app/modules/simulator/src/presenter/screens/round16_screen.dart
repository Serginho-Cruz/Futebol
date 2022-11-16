import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:futebol/app/modules/simulator/src/presenter/controllers/selection_store.dart';

import '../../domain/entities/Match/match_entity.dart';
import '../../domain/models/match_model.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../controllers/match_store.dart';
import '../widgets/Cards/group_match_card.dart';
import '../widgets/my_scaffold.dart';

class Round16Screen extends StatefulWidget {
  const Round16Screen({super.key});

  @override
  State<Round16Screen> createState() => _Round16ScreenState();
}

class _Round16ScreenState extends State<Round16Screen> {
  final MatchStore store = Modular.get<MatchStore>();
  final SelectionStore selectionStore = Modular.get<SelectionStore>();
  List<FocusNode> focusNodes = [];

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
    return ScopedBuilder<MatchStore, Failure, List<SoccerMatch>>(
      store: store,
      onLoading: (ctx) => const CircularProgressIndicator(),
      onError: (ctx, error) => Text(error.toString()),
      onState: (ctx, matchs) {
        List<GroupMatchCard> cards = [];
        for (var match in matchs) {
          FocusNode _focus1 = FocusNode();
          FocusNode _focus2 = FocusNode();

          focusNodes.addAll([_focus1, _focus2]);

          cards.add(
            GroupMatchCard(
              focus1: _focus1,
              focus2: _focus2,
              matchStore: store,
              hasMatchsFinished: () {
                for (var card in cards) {
                  if (card.point1 == null || card.point2 == null) {
                    return false;
                  }
                }
                return true;
              },
              match: SoccerMatchModel(
                match: match,
                selection1: selectionStore.state
                    .firstWhere((element) => element.id == match.idSelection1),
                selection2: selectionStore.state
                    .firstWhere((element) => element.id == match.idSelection2),
              ),
            ),
          );
        }
        return MyScaffold(
          body: SingleChildScrollView(
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
                GridView.count(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  crossAxisSpacing: 18.0,
                  mainAxisSpacing: 18.0,
                  crossAxisCount: 2,
                  children: cards,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (var focus in focusNodes) {
      focus.dispose();
    }
    super.dispose();
  }
}
