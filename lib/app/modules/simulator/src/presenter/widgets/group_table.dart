import 'package:flutter/material.dart';
import 'selection_data.dart';
import 'table_index.dart';

import '../../domain/entities/Selection/selection_entity.dart';

class GroupTable extends StatelessWidget {
  final List<Selecao> selections;
  final String group;
  final void Function()? onTap;

  const GroupTable({
    super.key,
    required this.group,
    required this.selections,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [];
    var width = MediaQuery.of(context).size.width;

    rows.add(_generateIndexRow());

    for (var selection in selections) {
      selection.id % 4 != 0
          ? rows.add(_generateRow(selection, width))
          : rows.add(_generateLastRow(selection));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 315,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 5.0,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.025,
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    color: Color.fromRGBO(115, 2, 23, 1),
                  ),
                  height: 40.0,
                  child: Center(
                    child: Text(
                      'Grupo $group',
                      style: const TextStyle(
                        color: Color.fromRGBO(217, 178, 130, 0.81),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Table(
                  columnWidths: {
                    0: FixedColumnWidth(width * 0.35),
                    1: FixedColumnWidth(width * 0.12),
                    2: FixedColumnWidth(width * 0.12),
                    3: FixedColumnWidth(width * 0.12),
                    4: FixedColumnWidth(width * 0.12),
                    5: FixedColumnWidth(width * 0.12),
                    6: FixedColumnWidth(width * 0.12),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: rows,
                  border: TableBorder.all(
                    style: BorderStyle.solid,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TableRow _generateLastRow(Selecao selection) {
  return TableRow(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      color: Color.fromARGB(255, 89, 24, 55),
    ),
    children: [
      Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            width: 50.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/flags/${selection.bandeira}.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Text(
              selection.nome,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      SelectionData(text: selection.pontos.toString()),
      SelectionData(text: selection.vitorias.toString()),
      SelectionData(text: selection.gp.toString()),
      SelectionData(text: selection.gc.toString()),
      SelectionData(text: '${selection.gp - selection.gc}'),
    ],
  );
}

TableRow _generateIndexRow() {
  return const TableRow(
    decoration: BoxDecoration(
      color: Color.fromRGBO(115, 18, 63, 1),
    ),
    children: [
      TableIndex(text: 'Times'),
      TableIndex(text: 'P'),
      TableIndex(text: 'V'),
      TableIndex(text: 'GP'),
      TableIndex(text: 'GC'),
      TableIndex(text: 'SG'),
    ],
  );
}

TableRow _generateRow(Selecao selection, double width) {
  return TableRow(
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 89, 24, 55),
    ),
    children: [
      Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            width: 50.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/flags/${selection.bandeira}.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Text(
              selection.nome,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      SelectionData(text: selection.pontos.toString()),
      SelectionData(text: selection.vitorias.toString()),
      SelectionData(text: selection.gp.toString()),
      SelectionData(text: selection.gc.toString()),
      SelectionData(text: '${selection.gp - selection.gc}'),
    ],
  );
}
