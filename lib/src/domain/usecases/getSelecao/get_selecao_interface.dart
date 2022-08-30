import 'package:dartz/dartz.dart';
import 'package:futebol/src/errors/errors.dart';

import '../../selecao_entity.dart';

abstract class IGetSelecao {
  Future<Either<Failure, Selecao>> call(int id);
}
