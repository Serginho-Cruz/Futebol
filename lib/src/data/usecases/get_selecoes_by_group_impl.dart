import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/domain/usecases/getSelecoesByGroup/get_selecoes_by_group_interface.dart';
import 'package:futebol/src/errors/errors.dart';

import '../repository/repository_interface.dart';

class GetSelecoesByGroup implements IGetSelecoesByGroup {
  final IRepository repository;

  GetSelecoesByGroup(this.repository);
  @override
  Future<Either<Failure, List<Selecao>>> call(String group) async {
    if (group.trim().isEmpty || group.length > 1) {
      return Left(InvalidGroupText());
    }

    group = group.toUpperCase();
    return await repository.getSelecoesByGroup(group);
  }
}
