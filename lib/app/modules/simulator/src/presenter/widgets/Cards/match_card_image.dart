import 'package:flutter/material.dart';

import '../../../domain/entities/Selection/selection_entity.dart';

class MatchCardImage extends StatelessWidget {
  MatchCardImage({super.key, required Selecao selection}) {
    _selection = selection;
  }

  late final Selecao _selection;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.5,
      height: 54.5,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.6),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/flags/${_selection.bandeira}.png'),
        ),
      ),
    );
  }
}
