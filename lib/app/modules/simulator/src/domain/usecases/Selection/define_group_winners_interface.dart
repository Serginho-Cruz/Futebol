import '../../entities/Selection/selection_entity.dart';

abstract class IDefineGroupWinners {
  List<Selecao> call(List<Selecao> selections);
}
