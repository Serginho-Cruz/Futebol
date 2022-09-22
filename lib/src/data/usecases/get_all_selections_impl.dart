import 'package:dartz/dartz.dart';
import 'package:futebol/src/data/repository/selection_repository_interface.dart';
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';
import 'package:futebol/src/domain/usecases/getAllSelections/get_all_selections_interface.dart';
import '../../errors/errors_classes/errors_classes.dart';

class GetAllSelectionsUC implements IGetAllSelections {
  final ISelectionRepository repository;

  GetAllSelectionsUC(this.repository);

  @override
  Future<Either<Failure, List<Selecao>>> call() async {
    var result = await repository.getAllSelections();

    return result;
  }
}
