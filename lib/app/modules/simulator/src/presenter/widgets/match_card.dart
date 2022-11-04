import 'package:flutter/material.dart';
import 'package:futebol/app/modules/simulator/src/domain/models/match_model.dart';

import 'match_card_image.dart';
import 'match_point.dart';

class MatchCard extends StatelessWidget {
  MatchCard({super.key, required this.match});

  SoccerMatchModel match;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      color: Theme.of(context).colorScheme.surface,
      elevation: 30.0,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Color.fromRGBO(74, 78, 105, 0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 35,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF730217),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
            ),
            child: Text(
              '${match.date}/2022',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(match.hour),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MatchCardImage(selection: match.selection1),
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 17.5),
                  child: MatchPoint(),
                ),
              ),
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 17.5),
                  child: MatchPoint(),
                ),
              ),
              MatchCardImage(selection: match.selection2),
            ],
          ),
          Text(
            match.local,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          )
        ],
      ),
    );
  }
}
