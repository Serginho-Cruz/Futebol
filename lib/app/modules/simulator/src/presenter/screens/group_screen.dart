import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../domain/entities/Match/match_entity.dart';
import '../../domain/models/match_model.dart';
import '../widgets/Cards/group_match_card.dart';
import '../controllers/match_store.dart';
import '../widgets/GroupTable/group_table.dart';
import '../../domain/entities/Selection/selection_entity.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../controllers/selection_store.dart';
import '../widgets/my_scaffold.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key, required this.group});

  final String group;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final selectionStore = Modular.get<SelectionStore>();
  final matchStore = Modular.get<MatchStore>();

  late List<Selecao> selections;

  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      selectionStore.getSelectionsByGroup(widget.group);
      matchStore.getMatchsByGroup(widget.group);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScopedBuilder<SelectionStore, Failure, List<Selecao>>(
              store: selectionStore,
              onLoading: (context) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightBlue,
                  ),
                ),
              ),
              onError: (context, error) => Text(
                error.toString(),
                style: const TextStyle(
                  fontSize: 28.0,
                  color: Colors.red,
                ),
              ),
              onState: (context, selections) {
                this.selections = selections;
                return GroupTable(
                  group: widget.group,
                  selections: selections,
                );
              },
            ),
            ScopedBuilder<MatchStore, Failure, List<SoccerMatch>>(
              store: matchStore,
              onLoading: (context) => const CircularProgressIndicator(),
              onError: (context, error) => Text(error.toString()),
              onState: (context, matchs) {
                List<GroupMatchCard> cards = [];

                for (var match in matchs) {
                  FocusNode focus1 = FocusNode();
                  FocusNode focus2 = FocusNode();

                  focusNodes.addAll([focus1, focus2]);
                  cards.add(
                    GroupMatchCard(
                      matchStore: matchStore,
                      focus1: focus1,
                      focus2: focus2,
                      hasMatchsFinished: () {
                        for (var card in cards) {
                          if (card.match.score1 == null ||
                              card.match.score2 == null) {
                            return false;
                          }
                        }
                        return true;
                      },
                      match: SoccerMatchModel(
                        match: match,
                        selection1: selections.firstWhere(
                            (selection) => selection.id == match.idSelection1),
                        selection2: selections.firstWhere(
                            (selection) => selection.id == match.idSelection2),
                      ),
                    ),
                  );
                }

                return GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                  crossAxisCount: 2,
                  physics: const BouncingScrollPhysics(),
                  children: cards,
                );
              },
            )
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
}
