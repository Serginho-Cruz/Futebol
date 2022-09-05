import 'package:futebol/src/domain/entities/selecao_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:futebol/src/domain/usecases/getSelection/get_selection_by_id_interface.dart';
import 'package:futebol/src/errors/errors_mensages_classes/errors_mensages.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../repository/repository_interface.dart';

class GetSelectionUC implements IGetSelection {
  final IRepository repository;

  GetSelectionUC(this.repository);
  @override
  Future<Either<Failure, Selecao>> call(int id) async {
    return id < 1
        ? Left(InvalidId(Messages.invalidId))
        : await repository.getSelection(id);
  }
}
