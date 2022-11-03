import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../widgets/group_table.dart';

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
        onState: (context, state) {
          return GroupTable(
            group: widget.group,
            selections: state,
          );
        },
      ),
    );
  }
}
