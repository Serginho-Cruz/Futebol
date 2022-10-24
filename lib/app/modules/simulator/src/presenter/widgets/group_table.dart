import 'package:flutter/material.dart';

import '../../domain/entities/Selection/selection_entity.dart';

class GroupTable extends StatelessWidget {
  final List<Selecao> selections;
  final String group;

  const GroupTable({
    super.key,
    required this.group,
    required this.selections,
  });

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [];

    rows.add(_generateIndexRow());

    for (var selection in selections) {
      rows.add(_generateRow(selection));
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          width: 255.0,
          height: 60.0,
          color: const Color.fromRGBO(115, 2, 23, 0.81),
          child: Text(
            'Grupo $group',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Table(
          columnWidths: const {
            0: FixedColumnWidth(120.0),
            1: FixedColumnWidth(45.0),
            2: FixedColumnWidth(45.0),
            3: FixedColumnWidth(45.0),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: rows,
          border: TableBorder.all(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: const Color.fromARGB(255, 34, 34, 59),
          ),
        ),
      ],
    );
  }
}

TableRow _generateIndexRow() {
  return const TableRow(
    children: [
      Text(
        'Times',
        style: TextStyle(fontSize: 18.0),
        textAlign: TextAlign.center,
      ),
      Text(
        'P',
        style: TextStyle(fontSize: 18.0),
        textAlign: TextAlign.center,
      ),
      Text(
        'V',
        style: TextStyle(fontSize: 18.0),
        textAlign: TextAlign.center,
      ),
      Text(
        'GP',
        style: TextStyle(fontSize: 18.0),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

TableRow _generateRow(Selecao selection) {
  return TableRow(
    decoration: const BoxDecoration(
      color: Color.fromRGBO(89, 24, 55, 0.81),
    ),
    children: [
      Row(
        children: [
          Container(
            width: 50.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/flags/${selection.bandeira}.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            selection.nome,
            style: const TextStyle(
              color: Color.fromARGB(1, 217, 178, 130),
            ),
          ),
        ],
      ),
      Text(
        '${selection.pontos}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        '${selection.vitorias}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        '${selection.gp}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
