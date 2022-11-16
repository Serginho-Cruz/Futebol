import 'package:futebol/app/modules/simulator/src/domain/entities/Selection/selection_entity.dart';

abstract class IDefineGroupWinners {
  List<Selecao> call(List<Selecao> selections);
}
