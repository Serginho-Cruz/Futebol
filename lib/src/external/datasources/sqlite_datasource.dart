import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/selecao_entity.dart';
import 'package:futebol/src/domain/selecao_mapper.dart';
import 'package:futebol/src/infra/datasource/datasource_interface.dart';
import '../../../helpers/fake_db.dart';
import '../../errors/errors.dart';

class SQLitedatasource implements IDataSource {
  final FakeDB db;

  SQLitedatasource(this.db);

  @override
  Future<Either<Failure, List<Selecao>>> getAllSelecoes() async {
    try {
      List<Selecao> selecoes = List.empty(growable: true);
      var list = await db.getAll();

      for (var element in list) {
        selecoes.add(SelecaoMapper.fromMap(element));
      }
      return Right(selecoes);
    } on DataSourceError catch (e) {
      return Left(e);
    } on EmptyList catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, List<Selecao>>> getSelecaoByGroup(String group) async {
    try {
      List<Selecao> selecoes = List.empty(growable: true);
      var list = await db.getByGroup(group);

      if (list.isEmpty) {
        return Left(EmptyList("No Selecoes found"));
      }

      for (var element in list) {
        selecoes.add(SelecaoMapper.fromMap(element));
      }

      return Right(selecoes);
    } on DataSourceError catch (e) {
      return Left(e);
    } on EmptyList catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, Selecao>> getSelecaoById(int id) async {
    try {
      var selecao = await db.getSelecaoById(id);

      return Right(SelecaoMapper.fromMap(selecao));
    } on DataSourceError catch (e) {
      return Left(e);
    } on EmptyList catch (e) {
      return Left(e);
    } on SelecaoError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(DataSourceError());
    }
  }
}
