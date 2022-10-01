import 'package:dartz/dartz.dart';

import 'package:futebol/src/data/repository/selection_repository_interface.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/errors/errors_messages_classes/errors_messages.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../datasource/datasource_interface.dart';

class SelectionRepository implements ISelectionRepository {
  IDataSource datasource;

  SelectionRepository(this.datasource);
  @override
  Future<Either<Failure, List<Selecao>>> getAllSelections() async {
    try {
      var list = await datasource.getAllSelections();
      return Right(list);
    } on NoSelectionsFound catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError(Messages.genericError));
    }
  }

  @override
  Future<Either<Failure, Selecao>> getSelection(int id) async {
    try {
      var result = await datasource.getSelectionById(id);
      return Right(result);
    } on NoSelectionsFound catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError(Messages.genericError));
    }
  }

  @override
  Future<Either<Failure, List<Selecao>>> getSelectionsByGroup(
      String group) async {
    try {
      var list = await datasource.getSelectionsByGroup(group);
      return Right(list);
    } on NoSelectionsFound catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError(Messages.genericError));
    }
  }

  @override
  Future<Either<Failure, List<Selecao>>> getSelectionsByIds(
      List<int> ids) async {
    try {
      var result = await datasource.getSelectionsByids(ids);
      return Right(result);
    } on NoSelectionsFound catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError(Messages.genericError));
    }
  }

  @override
  Future<Either<Failure, int>> updateSelectionsStatistics(
      List<Selecao> selections) async {
    try {
      var result = await datasource.updateSelectionsStatistics(selections);
      return Right(result);
    } on NoSelectionsFound catch (e) {
      return Left(e);
    } on DataSourceError catch (e) {
      return Left(e);
    } on Exception {
      return Left(DataSourceError(Messages.genericError));
    }
  }
}
