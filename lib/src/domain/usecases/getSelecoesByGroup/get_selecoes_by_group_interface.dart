import 'package:futebol/src/domain/selecao_entity.dart';

abstract class IGetSelecoesByGroup {
  List<Selecao> call();
}
