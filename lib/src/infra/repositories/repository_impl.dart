// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:futebol/src/data/repository/repository_interface.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/errors/errors.dart';

import '../datasource/datasource_interface.dart';

class Repository implements IRepository {
  IDataSource datasource;
  Repository({
    required this.datasource,
  });
  @override
  Future<Either<Failure, List<Selecao>>> getAllSelecoes() async {
    var list = await datasource.getAllSelecoes();
    return list.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, Selecao>> getSelecao(int id) async {
    var selecao = await datasource.getSelecaoById(id);
    return selecao.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<Selecao>>> getSelecoesByGroup(
      String group) async {
    var list = await datasource.getSelecaoByGroup(group);
    return list.fold((l) => Left(l), (r) => Right(r));
  }
}
