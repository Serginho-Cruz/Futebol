import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/usecases/getSelecao/get_selecao_interface.dart';
import 'package:futebol/src/errors/errors.dart';

import '../repository/repository_interface.dart';

class GetSelecao implements IGetSelecao {
  final IRepository repository;

  GetSelecao(this.repository);
  @override
  Future<Either<Failure, Selecao>> call(int id) async {
    return id < 1 ? Left(InvalidId()) : await repository.getSelecao(id);
  }
}
