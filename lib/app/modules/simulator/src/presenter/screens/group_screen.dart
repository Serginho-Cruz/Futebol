import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:futebol/app/modules/simulator/src/domain/entities/Match/match_entity.dart';
import 'package:futebol/app/modules/simulator/src/domain/models/match_model.dart';
import '../controllers/match_store.dart';
import '../widgets/group_table.dart';

import '../widgets/match_card.dart';

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

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      selectionStore.getSelectionsByGroup(widget.group);
    });
    return MyScaffold(
      body: ScopedBuilder<SelectionStore, Failure, List<Selecao>>(
        store: selectionStore,
        onLoading: (context) => const CircularProgressIndicator(),
        onError: (context, error) => Text(error.toString()),
        onState: (context, selections) {
          Future.delayed(Duration.zero, () {
            matchStore.getMatchsByGroup(widget.group);
          });
          return ScopedBuilder<MatchStore, Failure, List<SoccerMatch>>(
            store: matchStore,
            onLoading: (context) => const CircularProgressIndicator(),
            onError: (context, error) => Text(error.toString()),
            onState: (context, matchs) {
              List<MatchCard> cards = [];

              for (var match in matchs) {
                cards.add(
                  MatchCard(
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

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GroupTable(
                      group: widget.group,
                      selections: selections,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      crossAxisCount: 2,
                      physics: const BouncingScrollPhysics(),
                      children: cards,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
