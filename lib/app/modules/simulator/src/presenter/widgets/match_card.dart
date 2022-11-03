import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futebol/app/modules/simulator/src/domain/models/match_model.dart';

class MatchCard extends StatelessWidget {
  MatchCard({super.key, required this.match});

  SoccerMatchModel match;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.red,
            child: Text(match.date),
          ),
          Text(match.hour),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              children: [
                Container(
                  width: 60.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          'images/flags/${match.selection1.bandeira}.png'),
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  maxLength: 2,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardAppearance: Brightness.light,
                ),
                const Text('vs'),
                TextField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      maxWidth: 60.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  maxLength: 2,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardAppearance: Brightness.light,
                ),
                Container(
                  width: 40.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          'images/flags/${match.selection2.bandeira}.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
