import 'package:dartz/dartz.dart';
import '../../../errors/errors_classes/errors_classes.dart';
import '../../entities/selecao_entity.dart';

abstract class IGetSelection {
  Future<Either<Failure, Selecao>> call(int id);
}
