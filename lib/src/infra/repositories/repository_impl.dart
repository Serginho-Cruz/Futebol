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
    try {
      var list = await datasource.getAllSelecoes();
      return Right(list);
    } on EmptyList catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, Selecao>> getSelecao(int id) async {
    try {
      var selecao = await datasource.getSelecaoById(id);
      return Right(selecao);
    } on SelecaoError catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, List<Selecao>>> getSelecoesByGroup(
      String group) async {
    try {
      var list = await datasource.getSelecaoByGroup(group);
      return Right(list);
    } on EmptyList catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError());
    }
  }
}
