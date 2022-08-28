import 'package:dartz/dartz.dart';
import 'package:futebol/src/data/repository/repository_interface.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/domain/usecases/getAllSelecoes/get_all_selecoes_interface.dart';

import '../../errors/errors.dart';

class GetAllSelecoes implements IGetAllSelecoes {
  final IRepository repository;

  GetAllSelecoes(this.repository);

  @override
  Future<Either<Failure, List<Selecao>>> call() async {
    var result = await repository.getAllSelecoes();

    return result;
  }
}
