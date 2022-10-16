import 'package:dartz/dartz.dart';
import '../../repository/selection_repository_interface.dart';
import '../../../domain/entities/Selection/selection_entity.dart';
import '../../../domain/usecases/Selection/get_all_selections_interface.dart';
import '../../../errors/errors_classes/errors_classes.dart';

class GetAllSelectionsUC implements IGetAllSelections {
  final ISelectionRepository repository;

  GetAllSelectionsUC(this.repository);

  @override
  Future<Either<Failure, List<Selecao>>> call() async {
    var result = await repository.getAllSelections();

    return result;
  }
}
