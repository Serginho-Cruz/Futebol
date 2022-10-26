import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:futebol/app/modules/simulator/src/presenter/controllers/selection_store.dart';

import '../../domain/entities/Selection/selection_entity.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../widgets/group_table.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SelectionStore store = Modular.get<SelectionStore>();

  @override
  Widget build(BuildContext context) {
    store.getAllSelections();

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0))),
        title: const Text(
          'Simulador',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26.0,
          ),
        ),
        backgroundColor: const Color.fromARGB(155, 115, 18, 63),
        centerTitle: true,
        elevation: 30.0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.white,
              size: 45.0,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(135, 89, 24, 55),
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
              ),
            );
          }
          return ListView(
            children: tables,
          );
        },
      ),
    );
  }
}
