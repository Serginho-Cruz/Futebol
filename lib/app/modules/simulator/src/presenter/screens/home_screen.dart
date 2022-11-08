import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../controllers/selection_store.dart';

import '../../domain/entities/Selection/selection_entity.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../widgets/group_table.dart';
import '../widgets/my_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SelectionStore store = Modular.get<SelectionStore>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      store.getAllSelections();
    });

    return MyScaffold(
      body: ScopedBuilder<SelectionStore, Failure, List<Selecao>>(
        store: store,
        onLoading: ((context) => const CircularProgressIndicator()),
        onError: (ctx, failure) => Center(
          child: Text(
            '${failure.toString()}, por favor recarregue',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 24.0,
            ),
          ),
        ),
        onState: (context, state) {
          List<GroupTable> tables = [];
          for (int i = 0; i < state.length - 1; i = i + 4) {
            tables.add(
              GroupTable(
                group: state[i].grupo,
                selections: state.sublist(i, i + 4),
                onTap: () => Modular.to
                    .pushNamed('/group', arguments: state[i].grupo)
                    .then(
                      (_) => store.getAllSelections(),
                    ),
              ),
            );
          }
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: tables,
          );
        },
      ),
    );
  }
}
