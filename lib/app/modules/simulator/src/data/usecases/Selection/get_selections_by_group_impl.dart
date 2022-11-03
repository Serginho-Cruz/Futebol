import 'package:dartz/dartz.dart';

import '../../../domain/entities/Selection/selection_entity.dart';
import '../../../domain/usecases/Selection/get_selections_by_group_interface.dart';
import '../../../errors/errors_classes/errors_classes.dart';
import '../../repository/selection_repository_interface.dart';

class GetSelectionsByGroupUC implements IGetSelectionsByGroup {
  final ISelectionRepository repository;

  GetSelectionsByGroupUC(this.repository);
  @override
  Future<Either<Failure, List<Selecao>>> call(String group) async {
    return await repository.getSelectionsByGroup(group.toUpperCase());
  }
}
