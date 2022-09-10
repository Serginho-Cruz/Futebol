import 'package:dartz/dartz.dart';

import '../../domain/entities/Selection/selection_entity.dart';
import '../../domain/usecases/getSelection/get_selection_by_id_interface.dart';
import '../../errors/errors_classes/errors_classes.dart';
import '../../errors/errors_messages_classes/errors_messages.dart';
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
